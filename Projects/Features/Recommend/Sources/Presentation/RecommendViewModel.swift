//
//  RecommendViewModel.swift
//  Recommend
//
//  Created by 김종윤 on 7/6/24.
//

import UIKit
import SwiftUI
import Combine

import PPACUtil
import PPACDomain
import PPACModels
import PPACAnalytics

public protocol RecommendRouting: AnyObject {
  func showShareView(items: [Any])
  func showMemeDetailView(meme: MemeDetail)
}

public final class RecommendViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case viewInitialized
    case showRecommendMeme(meme: MemeDetail?)
    case likeButtonTapped(memeId: String?, tapCount: Int)
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
  
  weak var router: RecommendRouting?
  @Published public var state: State
  
  private let getRecommendMemesUseCase: GetRecommendMemesUseCase
  private let getUserInfoUseCase: GetUserInfoUseCase
  private let watchMemeUseCase: WatchMemeUseCase
  private let reactToMemeUseCase: ReactToMemeUseCase
  private let bookmarkMemeUseCase: BookmarkMemeUseCase
  private let getMemeDetailUseCase: GetMemeDetailUseCase
  private let deepLinkMemeId: PassthroughSubject<String, Never>
  private var cancellables: Set<AnyCancellable> = []
  
  public init(
    router: RecommendRouter?,
    getRecommendMemesUseCase: GetRecommendMemesUseCase,
    getUserInfoUseCase: GetUserInfoUseCase,
    watchMemeUseCase: WatchMemeUseCase,
    reactToMemeUseCase: ReactToMemeUseCase,
    bookmarkMemeUseCase: BookmarkMemeUseCase,
    getMemeDetailUseCase: GetMemeDetailUseCase,
    deepLinkMemeId: PassthroughSubject<String, Never>
  ) {
    self.router = router
    self.getRecommendMemesUseCase = getRecommendMemesUseCase
    self.getUserInfoUseCase = getUserInfoUseCase
    self.watchMemeUseCase = watchMemeUseCase
    self.reactToMemeUseCase = reactToMemeUseCase
    self.bookmarkMemeUseCase = bookmarkMemeUseCase
    self.getMemeDetailUseCase = getMemeDetailUseCase
    self.deepLinkMemeId = deepLinkMemeId
    self.state = State(
      recommendMemes: [],
      recommendMemeSize: 0,
      userLevel: 0,
      memeRecommendWatchCount: 0,
      isSuccessFetch: false
    )
    bind()
  }
  
  public func dispatch(type: Action) {
    Task { @MainActor in
      switch(type) {
      case .viewInitialized:
        await getRecommendAndUser()
      case .showRecommendMeme(let meme):
        await postShownMeme(meme: meme)
      case .likeButtonTapped(let memeId, let tapCount):
        await postReaction(memeId: memeId, tapCount: tapCount)
      case .copyButtonTapped(let meme):
        await copyImage(meme: meme)
      case .shareButtonTapped(let meme):
        await showShareSheet(meme: meme)
      case .farmemeButtonTapped(let meme):
        await saveMeme(meme: meme)
      }
    }
  }
  
  public func logRecommend(
    interaction: PPACAnalytics.UserInteraction = .click,
    event: PPACAnalytics.UserEvent,
    meme: MemeDetail?
  ) {
    PPACAnalytics.shared
      .log(
        interaction: interaction,
        event: event,
        page: .recommend,
        memeId: meme?.id,
        memeTitle: meme?.title
      )
  }
}

private extension RecommendViewModel {
  
  func bind() {
    deepLinkMemeId.sink { [weak self] memeId in
      guard let self = self else { return }
      Task { @MainActor in
        print("👍 deepLinkMemeId: \(memeId)")
        do {
          let meme = try await self.getMemeDetailUseCase.execute(memeId: memeId)
          print("👍 meme: \(meme)")
          self.router?.showMemeDetailView(meme: meme)
        } catch {
          debugPrint("Failed get meme detail : \(error)")
        }
      }
      
    }.store(in: &cancellables)
  }
  
  @MainActor
  func getRecommendAndUser() async {
    do {
      let recommendMemeSize = 5
      let recommendMemes = try await getRecommendMemesUseCase.execute(size: recommendMemeSize)
      let user = try await getUserInfoUseCase.execute()
      print("👍memeids: \(recommendMemes.map { $0.id })")
      DispatchQueue.main.asyncAfter(deadline: .now()) {
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
      self.logRecommend(interaction: .view, event: .meme, meme: meme)
    } catch {
      debugPrint("Failed show recommnedMeme : \(error)")
    }
  }
  
  @MainActor
  func postReaction(memeId: String?, tapCount: Int) async {
    guard let memeId else { return }
    do {
      let memeReactionCount = try await reactToMemeUseCase.execute(
        memeId: memeId,
        count: tapCount
      )
      
      if let index = self.state.recommendMemes.firstIndex(where: { $0.id == memeId }) {
        self.state.recommendMemes[index].isReaction = true
        self.state.recommendMemes[index].reaction = memeReactionCount
        self.logRecommend(event: .reaction, meme: self.state.recommendMemes[index])
      }
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
      self.logRecommend(event: .copy, meme: meme)
    } catch {
      debugPrint("Failed to load image data: \(error)")
    }
  }
  
  @MainActor
  func showShareSheet(meme: MemeDetail?)  async {
     guard let meme else { return }
    guard let memeId = self.state.recommendMemes.filter({ $0.imageUrlString == meme.imageUrlString }).first?.id else {
      return
    }
    let deeplinkUrl = "https://farmeme.onelink.me/RtpU/y09dosru?deep_link_value=\(memeId)"
    router?.showShareView(items: [deeplinkUrl])
    self.logRecommend(event: .share, meme: meme)
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
        self.logRecommend(event: .saveCancel, meme: meme)
      } catch {
        debugPrint("Faild delete meme : \(error)")
      }
    } else {
      do {
        try await bookmarkMemeUseCase.execute(memeId: selectedMeme.id)
        self.state.recommendMemes[memeIdx].isFarmemed = true
        self.logRecommend(event: .save, meme: meme)
        
      } catch {
        debugPrint("Failed save meme : \(error)")
      }
    }
  }
 
}
