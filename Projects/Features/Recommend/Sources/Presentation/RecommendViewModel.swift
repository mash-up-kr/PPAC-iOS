//
//  RecommendViewModel.swift
//  Recommend
//
//  Created by 김종윤 on 7/6/24.
//

import UIKit
import SwiftUI

import PPACUtil
import PPACDomain
import PPACModels

public protocol RecommendRouting: AnyObject {
  func showShareView(items: [Any])
}

public final class RecommendViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case initializeView
    case showRecommendMeme(memeId: String?)
    case likeButtonTapped(memeId: String?)
    case copyButtonTapped(memeImageUrl: String?)
    case shareButtonTapped(memeImageUrl: String?)
    case farmemeButtonTapped(memeId: String?)
  }
  
  public struct State {
    var recommendMemes: [MemeDetail]
    var userLevel: Int
    var memeRecommendWatchCount: Int
  }
  
  weak var router: RecommendRouter?
  @Published public var state: State
  
  private let getRecommendMemesUseCase: GetRecommendMemesUseCase
  private let getUserInfoUseCase: GetUserInfoUseCase
  private let watchMemeUseCase: WatchMemeUseCase
  private let reactToMemeUseCase: ReactToMemeUseCase
  private let bookmarkMemeUseCase: BookmarkMemeUseCase
  
  public init(
    router: RecommendRouter?,
    getRecommendMemesUseCase: GetRecommendMemesUseCase,
    getUserInfoUseCase: GetUserInfoUseCase,
    watchMemeUseCase: WatchMemeUseCase,
    reactToMemeUseCase: ReactToMemeUseCase,
    bookmarkMemeUseCase: BookmarkMemeUseCase
  ) {
    self.router = router
    self.getRecommendMemesUseCase = getRecommendMemesUseCase
    self.getUserInfoUseCase = getUserInfoUseCase
    self.watchMemeUseCase = watchMemeUseCase
    self.reactToMemeUseCase = reactToMemeUseCase
    self.bookmarkMemeUseCase = bookmarkMemeUseCase
    self.state = State(
      recommendMemes: [],
      userLevel: 0,
      memeRecommendWatchCount: 0
    )
  }
  
  public func dispatch(type: Action) {
    Task { @MainActor in
      switch(type) {
      case .initializeView:
        await getRecommendAndUser()
      case .showRecommendMeme(let memeId):
        await postShownMeme(memeId: memeId)
      case .likeButtonTapped(let memeId):
        await postReaction(memeId: memeId)
      case .copyButtonTapped(let memeImageUrl):
        await copyImage(memeImageUrl: memeImageUrl)
      case .shareButtonTapped(let memeImageUrl):
        await showShareSheet(memeImageUrl: memeImageUrl)
      case .farmemeButtonTapped(let memeId):
        await saveMeme(memeId: memeId)
      }
    }
  }
}

private extension RecommendViewModel {
  func getRecommendAndUser() async {
    do {
      let recommendMemes = try await getRecommendMemesUseCase.execute(size: 5)
      let user = try await getUserInfoUseCase.get()
      
      self.state.recommendMemes = recommendMemes
      self.state.userLevel = user.level
      self.state.memeRecommendWatchCount = user.memeRecommendWatchCount
      
    } catch {
      print("Failed get recommend memes : \(error)")
    }
  }
  
  func postShownMeme(memeId: String?) async {
    guard let memeId else { return }
    do {
      try await watchMemeUseCase.execute(memeId: memeId, type: "recommend")
      let user = try await getUserInfoUseCase.get()
      self.state.userLevel = user.level
      self.state.memeRecommendWatchCount = user.memeRecommendWatchCount
    } catch {
      print("Failed show recommnedMeme : \(error)")
    }
  }
  
  func postReaction(memeId: String?) async {
    guard let memeId else { return }
    do {
      try await reactToMemeUseCase.execute(memeId: memeId)
      
      if let index = self.state.recommendMemes.firstIndex(where: { $0.id == memeId }) {
        self.state.recommendMemes[index].reaction += 1
      }
    } catch {
      print("Failed post recation : \(error)")
    }
  }
  
  func copyImage(memeImageUrl: String?) async {
    guard let memeImageUrl else { return }
    
    guard let url = URL(string: memeImageUrl) else { return }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      guard let image = UIImage(data: data) else {
        return
      }

      UIPasteboard.general.image = image
    } catch {
      print("Failed to load image data: \(error)")
    }
  }
  
  func showShareSheet(memeImageUrl: String?) async {
    guard let memeImageUrl else { return }
    
    guard let url = URL(string: memeImageUrl) else {
      print("invalid url")
      return
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      guard let image = UIImage(data: data) else {
        print("invalid image data")
        return
      }
      await self.router?.showShareView(items: [image])
    } catch {
      print("Failed to load image data: \(error)")
    }
  }
  
  func saveMeme(memeId: String?) async {
    guard let memeId else { return }
    guard let index = self.state.recommendMemes.firstIndex(where: { $0.id == memeId }) else {
      print("not found meme. memeId: \(memeId)")
      return
    }
    
    if self.state.recommendMemes[index].isFarmemed {
      print("already farmeme.")
      return
    }
    
    do {
      try await bookmarkMemeUseCase.execute(memeId: self.state.recommendMemes[index].id)
      self.state.recommendMemes[index].isFarmemed = true
    } catch {
      print("Failed save meme : \(error)")
    }
  }
}
