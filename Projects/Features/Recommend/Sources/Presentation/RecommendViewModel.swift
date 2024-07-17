//
//  RecommendViewModel.swift
//  Recommend
//
//  Created by 김종윤 on 7/6/24.
//

import SwiftUI

import PPACUtil
import PPACDomain
import PPACModels

public protocol RecommendRouting: AnyObject {
  
}

public final class RecommendViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case initializeView
    case showRecommendMeme
    case likeButtonTapped
    case copyButtonTapped
    case shareButtonTapped
    case farmemeButtonTapped
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
  
  public init(
    router: RecommendRouter?,
    getRecommendMemesUseCase: GetRecommendMemesUseCase,
    getUserInfoUseCase: GetUserInfoUseCase
  ) {
    self.router = router
    self.getRecommendMemesUseCase = getRecommendMemesUseCase
    self.getUserInfoUseCase = getUserInfoUseCase
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
      case .showRecommendMeme:
        await postShownMeme()
      case .likeButtonTapped:
        await postLike()
      case .copyButtonTapped:
        await copyImage()
      case .shareButtonTapped:
        await showShareSheet()
      case .farmemeButtonTapped:
        await saveMeme()
      }
    }
  }
}

private extension RecommendViewModel {
  func getRecommendAndUser() async {
    do {
      UserInfo.shared.deviceId = "abcdefgh"
      
      let recommendMemes = try await getRecommendMemesUseCase.execute(size: 5)
      let user = try await getUserInfoUseCase.get()
      
      self.state.recommendMemes = recommendMemes
      self.state.userLevel = user.level
      self.state.memeRecommendWatchCount = user.memeRecommendWatchCount
      
    } catch {
      print("Failed get recommend memes : \(error)")
    }
  }
  
  func postShownMeme() async {
    
  }
  
  func postLike() async {
    
  }
  
  func copyImage() async {
    
  }
  
  func showShareSheet() async {
    
  }
  
  func saveMeme() async {
    
  }
}
