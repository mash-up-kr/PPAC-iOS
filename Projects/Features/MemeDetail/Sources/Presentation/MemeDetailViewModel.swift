//
//  MemeDetailViewModel.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import Foundation

import Dependencies

import PPACUtil
import PPACModels
import UIKit

protocol MemeDetailRouting: AnyObject {
  func popView()
  func showShareView()
}

final class MemeDetailViewModel: ViewModelType, ObservableObject {
  
  enum Action {
    case likeButtonTapped
    case copyButtonTapped
    case shreButtonTapped
    case farmemeButtonTapped
    case naviBackButtonTapped
  }
  
  struct State {
    var meme: MemeDetail
  }
  
  // MARK: - Properties
  
  weak var router: MemeDetailRouting?
  @Published var state: State
  
  private let copyImageUseCase: CopyImageUseCase
  private let postLikeUseCase: PostLikeUseCase
  
  
  // MARK: - Initializers
  
  init(
    meme: MemeDetail,
    router: MemeDetailRouting?,
    copyImageUseCase: CopyImageUseCase,
    postLikeUseCase: PostLikeUseCase
  ) {
    self.router = router
    self.state = State(meme: meme)
    self.copyImageUseCase = copyImageUseCase
    self.postLikeUseCase = postLikeUseCase
  }
  
  // MARK: - Methods
  
  func dispatch(type: Action) {
    switch type {
    case .likeButtonTapped:
      postLike()
    case .copyButtonTapped:
      copyImage()
    case .shreButtonTapped:
      router?.showShareView()
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
    // TODO: - 이미지 viewmodel이 알지 못하도록 수정
    let imageData: Data = try! Data(contentsOf: URL(string: state.meme.imageUrlString)!)
    copyImageUseCase.execute(data: imageData)
  }
  
  func postSavedFarmeme() {
    
  }
}
