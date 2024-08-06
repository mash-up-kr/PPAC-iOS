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
    case viewInitialized
    case showRecommendMeme(memeId: String?)
    case likeButtonTapped(memeId: String?)
    case copyButtonTapped(memeImageUrl: String?)
    case shareButtonTapped(memeImageUrl: String?)
    case farmemeButtonTapped(memeId: String?)
  }
  
  public struct State {
    var recommendMemes: [MemeDetail]
    var recommendMemeSize: Int
    var userLevel: Int
    var memeRecommendWatchCount: Int
    var isSuccessFetch: Bool
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
      recommendMemeSize: 0,
      userLevel: 0,
      memeRecommendWatchCount: 0,
      isSuccessFetch: false
    )
  }
  
  public func dispatch(type: Action) {
    Task { @MainActor in
      switch(type) {
      case .viewInitialized:
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
  
  @MainActor
  func getRecommendAndUser() async {
    do {
      let recommendMemeSize = 5
      let recommendMemes = try await getRecommendMemesUseCase.execute(size: recommendMemeSize)
      let user = try await getUserInfoUseCase.execute()
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.state.recommendMemes = recommendMemes
        self.state.recommendMemeSize = recommendMemes.count
        self.state.userLevel = user.level
        self.state.memeRecommendWatchCount = user.memeRecommendWatchCount
        self.state.isSuccessFetch = true
      }
    } catch {
      debugPrint("Failed get recommend memes : \(error)")
    }
  }
  
  @MainActor
  func postShownMeme(memeId: String?) async {
    guard let memeId else { return }
    do {
      try await watchMemeUseCase.execute(memeId: memeId, type: "recommend")
      let user = try await getUserInfoUseCase.execute()
      self.state.userLevel = user.level
      self.state.memeRecommendWatchCount = user.memeRecommendWatchCount
    } catch {
      debugPrint("Failed show recommnedMeme : \(error)")
    }
  }
  
  func postReaction(memeId: String?) async {
    guard let memeId else { return }
    do {
      try await reactToMemeUseCase.execute(memeId: memeId)
      
      if let index = self.state.recommendMemes.firstIndex(where: { $0.id == memeId }) {
        self.state.recommendMemes[index].isReaction = true
        self.state.recommendMemes[index].reaction += 1
      }
    } catch {
      debugPrint("Failed post recation : \(error)")
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
      debugPrint("Failed to load image data: \(error)")
    }
  }
  
  func showShareSheet(memeImageUrl: String?) async {
    guard let memeImageUrl else { return }
    
    guard let url = URL(string: memeImageUrl) else {
      debugPrint("invalid url")
      return
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      guard let image = UIImage(data: data) else {
        debugPrint("invalid image data")
        return
      }
      await self.router?.showShareView(items: [image])
    } catch {
      debugPrint("Failed to load image data: \(error)")
    }
  }
  
  func saveMeme(memeId: String?) async {
    guard let memeId else { return }
    
    guard let memeIdx = self.state.recommendMemes.firstIndex(where: { $0.id == memeId }) else {
      debugPrint("not found meme. memeId: \(memeId)")
      return
    }
    let meme = self.state.recommendMemes[memeIdx]
    
    if meme.isFarmemed {
      do {
        try await bookmarkMemeUseCase.delete(memeId: meme.id)
        self.state.recommendMemes[memeIdx].isFarmemed = false
      } catch {
        debugPrint("Faild delete meme : \(error)")
      }
    } else {
      do {
        try await bookmarkMemeUseCase.execute(memeId: meme.id)
        self.state.recommendMemes[memeIdx].isFarmemed = true
      } catch {
        debugPrint("Failed save meme : \(error)")
      }
    }
  }
}
