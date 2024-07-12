//
//  RecommendViewModel.swift
//  Recommend
//
//  Created by 김종윤 on 7/6/24.
//

import SwiftUI

import PPACUtil
import PPACModels

public protocol RecommendRouting: AnyObject {
  
}

public final class RecommendViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
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
  
  public init(
    router: RecommendRouter?,
    recommendMemes: [MemeDetail],
    user: UserDetail
  ) {
    self.router = router
    self.state = State(
      recommendMemes: recommendMemes,
      userLevel: user.level,
      memeRecommendWatchCount: user.memeRecommendWatchCount
    )
  }
  
  public func dispatch(type: Action) {
    switch(type) {
    case .showRecommendMeme:
      postShownMeme()
    case .likeButtonTapped:
      postLike()
    case .copyButtonTapped:
      copyImage()
    case .shareButtonTapped:
      showShareSheet()
    case .farmemeButtonTapped:
      saveMeme()
    }
  }
}

private extension RecommendViewModel {
  func postShownMeme() {
    
  }
  
  func postLike() {
    
  }
  
  func copyImage() {
    
  }
  
  func showShareSheet() {
    
  }
  
  func saveMeme() {
    
  }
}
