//
//  MemeDetailViewModel.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import UIKit

import Dependencies

import PPACUtil
import PPACModels
import PPACDomain

import PPACAnalytics

@MainActor
public protocol MemeDetailRouting: AnyObject {
  func popView()
  func showShareView(items: [Any])
}

public final class MemeDetailViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case likeButtonTapped
    case copyButtonTapped
    case shreButtonTapped
    case farmemeButtonTapped
    case naviBackButtonTapped
  }
  
  public struct State {
    var meme: MemeDetail
    var isCopied: Bool = false
    var isFarmemeChanged: Bool = false
    let reportProblemUrl: URL? = URL(string: "https://forms.gle/a5QkMnLD8AANtYCo7")
  }
  
  // MARK: - Properties
  
  weak var router: MemeDetailRouting?
  @Published public var state: State
  
  private let bookmarkMemeUseCase: BookmarkMemeUseCase
  private let shareMemeUseCase: ShareMemeUseCase
  private let watchMemeUseCase: WatchMemeUseCase
  private let reactToMemeUseCase: ReactToMemeUseCase
  
  private var reactionCount = 0
  private var reactionTask: Task<Void, Never>?
  
  private let trotller = Throttler(seconds: 3)
  
  // MARK: - Initializers
  
  public init(
    meme: MemeDetail,
    router: MemeDetailRouting?,
    bookmarkMemeUseCase: BookmarkMemeUseCase,
    shareMemeUseCase: ShareMemeUseCase,
    watchMemeUseCase: WatchMemeUseCase,
    reactToMemeUseCase: ReactToMemeUseCase
  ) {
    debugPrint("memeviewmodel init")
    self.router = router
    self.state = State(meme: meme)
    self.bookmarkMemeUseCase = bookmarkMemeUseCase
    self.shareMemeUseCase = shareMemeUseCase
    self.watchMemeUseCase = watchMemeUseCase
    self.reactToMemeUseCase = reactToMemeUseCase
  }
  
  deinit {
    debugPrint("memeviewmodel deinit")
    reactionTask?.cancel()
  }
  
  // MARK: - Methods
  
  public func dispatch(type: Action) {
    Task { @MainActor in
      debugPrint("type: \(type)")
      switch type {
      case .likeButtonTapped:
        postReaction()
      case .copyButtonTapped:
        await copyImage()
      case .shreButtonTapped:
        await showShareSheet()
      case .farmemeButtonTapped:
        if state.meme.isFarmemed {
          await postCancelFarmeme()
        } else {
          await postSavedFarmeme()
        }
      case .naviBackButtonTapped:
        await sendReactions()
        router?.popView()
      }
    }
  }
  
  public func logMemeDetail(
    interaction: PPACAnalytics.UserInteraction = .click,
    event: PPACAnalytics.UserEvent
  ) {
    PPACAnalytics.shared
      .log(
        interaction: interaction,
        event: event,
        page: .memeDetail,
        memeId: self.state.meme.id,
        memeTitle: self.state.meme.title
      )
  }
}

private extension MemeDetailViewModel {
  
  @MainActor
  func postReaction() {
    reactionCount += 1
    self.state.meme.reaction += 1
    self.state.meme.isReaction = true
    self.logMemeDetail(event: .reaction)
    
    trotller.throttle {
      await self.sendReactions()
    }
  }
  
  @MainActor
  func sendReactions() async {
    let count = reactionCount
    guard count > 0 else {
      // 전송할 리액션이 없음
      return
    }
    reactionCount = 0
    do {
      let count = try await reactToMemeUseCase.execute(memeId: state.meme.id, count: count)
      debugPrint("currentMeme count: \(self.state.meme.reaction)")
      debugPrint("new count: \(count)")
      self.state.meme.reaction = count
      debugPrint("Reactions sent successfully with count: \(count)")
    } catch {
      debugPrint("Failed to send reactions: \(error)")
    }
  }
  
  @MainActor
  func copyImage() async {
    guard let url = URL(string: self.state.meme.imageUrlString) else {
      return
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      guard let image = UIImage(data: data) else {
        return
      }
      UIPasteboard.general.image = image
      state.isCopied = true
      self.logMemeDetail(event: .copy)
    } catch {
      debugPrint("Failed to load image data: \(error)")
    }
  }
  
  @MainActor
  func postSavedFarmeme() async {
    if state.meme.isFarmemed { return }
    
    do {
      try await bookmarkMemeUseCase.execute(memeId: state.meme.id)
      state.meme.isFarmemed = true
      state.isFarmemeChanged = true
      self.logMemeDetail(event: .save)
    } catch {
      // TODO: - 에러처리
      debugPrint(error)
    }
  }
  
  @MainActor
  func postCancelFarmeme() async {
    if !state.meme.isFarmemed { return }
    
    do {
      try await bookmarkMemeUseCase.delete(memeId: state.meme.id)
      state.meme.isFarmemed = false
      state.isFarmemeChanged = true
      self.logMemeDetail(event: .saveCancel)
    } catch {
      // TODO: - 에러처리
      debugPrint(error)
    }
  }
  
  @MainActor
  func showShareSheet() async {
    do {
      let deeplinkUrl = "https://farmeme.onelink.me/RtpU/y09dosru?deep_link_value=\(self.state.meme.id)"
      self.router?.showShareView(items: [deeplinkUrl])
      try await self.shareMemeUseCase.execute(memeId: state.meme.id)
      self.logMemeDetail(event: .share)
    } catch {
      // TODO: - 에러처리
      debugPrint(error)
    }
  }
}
