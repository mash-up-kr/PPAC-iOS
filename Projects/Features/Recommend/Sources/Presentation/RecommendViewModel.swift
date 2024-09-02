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
import PPACAnalytics

public protocol RecommendRouting: AnyObject {
  func showShareView(items: [Any])
}

public final class RecommendViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case viewInitialized
    case showRecommendMeme(meme: MemeDetail?)
    case likeButtonTapped(meme: MemeDetail?)
    case copyButtonTapped(meme: MemeDetail?)
    case shareButtonTapped(meme: MemeDetail?)
    case farmemeButtonTapped(meme: MemeDetail?)
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
      case .showRecommendMeme(let meme):
        await postShownMeme(meme: meme)
      case .likeButtonTapped(let meme):
        await postReaction(meme: meme)
      case .copyButtonTapped(let meme):
        await copyImage(meme: meme)
      case .shareButtonTapped(let meme):
        await showShareSheet(meme: meme)
      case .farmemeButtonTapped(let meme):
        await saveMeme(meme: meme)
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
  func postShownMeme(meme: MemeDetail?) async {
    guard let meme else { return }
    do {
      try await watchMemeUseCase.execute(memeId: meme.id, type: "recommend")
      let user = try await getUserInfoUseCase.execute()
      self.state.userLevel = user.level
      self.state.memeRecommendWatchCount = user.memeRecommendWatchCount
      
      PPACAnalytics.shared
        .log(
          interaction: .view,
          event: .meme,
          page: .recommend,
          memeId: meme.id,
          memeTitle: meme.title
        )
    } catch {
      debugPrint("Failed show recommnedMeme : \(error)")
    }
  }
  
  func postReaction(meme: MemeDetail?) async {
    guard let meme else { return }
    do {
      try await reactToMemeUseCase.execute(memeId: meme.id)
      
      if let index = self.state.recommendMemes.firstIndex(where: { $0.id == meme.id }) {
        self.state.recommendMemes[index].isReaction = true
        self.state.recommendMemes[index].reaction += 1
      }
      
      PPACAnalytics.shared
        .log(
          interaction: .click,
          event: .reaction,
          page: .recommend,
          memeId: meme.id,
          memeTitle: meme.title
        )
      
    } catch {
      debugPrint("Failed post recation : \(error)")
    }
  }
  
  func copyImage(meme: MemeDetail?) async {
    guard let meme else { return }
    
    guard let url = URL(string: meme.imageUrlString) else { return }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      guard let image = UIImage(data: data) else {
        return
      }

      UIPasteboard.general.image = image
      
      PPACAnalytics.shared
        .log(
          interaction: .click,
          event: .copy,
          page: .recommend,
          memeId: meme.id,
          memeTitle: meme.title
        )
      
    } catch {
      debugPrint("Failed to load image data: \(error)")
    }
  }
  
  func showShareSheet(meme: MemeDetail?)  async {
    guard let meme else { return }
    
    guard let url = URL(string: meme.imageUrlString) else {
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
      
      PPACAnalytics.shared
        .log(
          interaction: .click,
          event: .share,
          page: .recommend,
          memeId: meme.id,
          memeTitle: meme.title
        )
      
    } catch {
      debugPrint("Failed to load image data: \(error)")
    }
  }
  
  func saveMeme(meme: MemeDetail?) async {
    guard let meme else { return }
    
    guard let memeIdx = self.state.recommendMemes.firstIndex(where: { $0.id == meme.id }) else {
      debugPrint("not found meme. memeId: \(meme.id)")
      return
    }
    let selectedMeme = self.state.recommendMemes[memeIdx]
    
    if selectedMeme.isFarmemed {
      do {
        try await bookmarkMemeUseCase.delete(memeId: selectedMeme.id)
        self.state.recommendMemes[memeIdx].isFarmemed = false
        
        PPACAnalytics.shared
          .log(
            interaction: .click,
            event: .saveCancel,
            page: .recommend,
            memeId: meme.id,
            memeTitle: meme.title
          )
      } catch {
        debugPrint("Faild delete meme : \(error)")
      }
    } else {
      do {
        try await bookmarkMemeUseCase.execute(memeId: selectedMeme.id)
        self.state.recommendMemes[memeIdx].isFarmemed = true
        
        PPACAnalytics.shared
          .log(
            interaction: .click,
            event: .save,
            page: .recommend,
            memeId: meme.id,
            memeTitle: meme.title
          )
        
      } catch {
        debugPrint("Failed save meme : \(error)")
      }
    }
  }
}
