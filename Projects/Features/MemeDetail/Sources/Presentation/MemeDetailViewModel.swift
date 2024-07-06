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
  
  private let postLikeUseCase: PostLikeUseCase
  
  // MARK: - Initializers
  
  public init(
    meme: MemeDetail,
    router: MemeDetailRouting?,
    postLikeUseCase: PostLikeUseCase
  ) {
    self.router = router
    self.state = State(meme: meme)
    self.postLikeUseCase = postLikeUseCase
  }
  
  // MARK: - Methods
  
  public func dispatch(type: Action) {
    switch type {
    case .likeButtonTapped:
      postLike()
    case .copyButtonTapped:
      copyImage()
    case .shreButtonTapped:
      showShareSheet()
    case .farmemeButtonTapped:
      postSavedFarmeme()
    case .naviBackButtonTapped:
      router?.popView()
    }
  }
}

private extension MemeDetailViewModel {
  func postLike() {
    
  }
  
  func copyImage() {
    DispatchQueue.main.async { [weak self] in
      guard let self,
            let url = URL(string: state.meme.imageUrlString),
            let imageData = try? Data(contentsOf: url) else {
        return
      }
      UIPasteboard.general.image = UIImage(data: imageData)
    }
  }
  
  func postSavedFarmeme() {
    
  }
  
  func showShareSheet() {
    guard let url = URL(string: state.meme.imageUrlString),
          let data = try? Data(contentsOf: url),
          let image = UIImage(data: data) else {
      return
    }
    router?.showShareView(items: [image])
  }
}
