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
    self.router = router
    self.state = State(meme: meme)
    self.bookmarkMemeUseCase = bookmarkMemeUseCase
    self.shareMemeUseCase = shareMemeUseCase
    self.watchMemeUseCase = watchMemeUseCase
    self.reactToMemeUseCase = reactToMemeUseCase
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
        await postSavedFarmeme()
      case .naviBackButtonTapped:
        router?.popView()
      }
    }
  }
}

private extension MemeDetailViewModel {
  
  func postReaction() async {
    do {
      try await reactToMemeUseCase.execute(memeId: state.meme.id, deviceId: "")
      print("reaction success")
    } catch {
      // TODO: - 에러처리
      print("Failed to post reaction: \(error)")
    }
  }
  
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
    } catch {
      print("Failed to load image data: \(error)")
    }
  }
  
  func postSavedFarmeme() async {
    do {
      try await bookmarkMemeUseCase.execute(memeId: state.meme.id, deviceId: "qwer1234")
    } catch {
      // TODO: - 에러처리
      print(error)
    }
  }
  
  func showShareSheet() async {
    guard let url = URL(string: self.state.meme.imageUrlString) else {
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
}
