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
  
  // MARK: - Initializers
  
  public init(
    meme: MemeDetail,
    router: MemeDetailRouting?,
    bookmarkMemeUseCase: BookmarkMemeUseCase,
    shareMemeUseCase: ShareMemeUseCase,
    watchMemeUseCase: WatchMemeUseCase,
    reactToMemeUseCase: ReactToMemeUseCase
  ) {
    print("memeviewmodel init")
    self.router = router
    self.state = State(meme: meme)
    self.bookmarkMemeUseCase = bookmarkMemeUseCase
    self.shareMemeUseCase = shareMemeUseCase
    self.watchMemeUseCase = watchMemeUseCase
    self.reactToMemeUseCase = reactToMemeUseCase
  }
  
  deinit {
      print("memeviewmodel deinit")
      reactionTask?.cancel()
  }
  
  // MARK: - Methods
  
  public func dispatch(type: Action) {
    Task { @MainActor in
      print("type: \(type)")
      switch type {
      case .likeButtonTapped:
        await postReaction()
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
      
      reactionTask?.cancel()
      
      reactionTask = Task { [weak self] in
          guard let self = self else { return }
          do {
              try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
              await self.sendReactions()
          } catch {
              if Task.isCancelled {
                  // 태스크가 취소되었으므로 아무 작업도 하지 않음
                  return
              } else {
                  print("Task error: \(error)")
              }
          }
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
        print("currentMeme count: \(self.state.meme.reaction)")
        print("new count: \(count)")
        self.state.meme.reaction = count
          print("Reactions sent successfully with count: \(count)")
      } catch {
          print("Failed to send reactions: \(error)")
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
      print("Failed to load image data: \(error)")
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
      print(error)
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
      print(error)
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
      print(error)
    }
  }
}
