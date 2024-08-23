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
}

private extension MemeDetailViewModel {
  
  @MainActor
  func postReaction() async {
    do {
      try await reactToMemeUseCase.execute(memeId: state.meme.id)
      self.state.meme.reaction += 1
      print("reaction success")
    } catch {
      // TODO: - 에러처리
      print("Failed to post reaction: \(error)")
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
    } catch {
      // TODO: - 에러처리
      print(error)
    }
  }
  
  @MainActor
  func showShareSheet() async {
    let deeplinkUrl = "https://farmeme.onelink.me/RtpU/y09dosru?deep_link_value=\(self.state.meme.id)"
    self.router?.showShareView(items: [deeplinkUrl])
  }
}
