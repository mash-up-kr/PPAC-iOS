//
//  RecommendRouter.swift
//  Recommend
//
//  Created by 김종윤 on 7/6/24.
//

import UIKit
import SwiftUI

import PPACUtil
import PPACModels
import PPACDomain
import PPACData
import PPACNetwork
import DesignSystem

public final class RecommendRouter: Router, RecommendRouting {
  
  // MARK: - Properties
  
  public var delegate: (any RouterDelegate)?
  
  public var navigationController: UINavigationController
  
  public var childRouters: [any Router] = []
  private var selectedTab: Binding<MainTab>
  
  // MARK: - Initializers
  
  public init(
    _ navigationController: UINavigationController,
    selectedTab: Binding<MainTab>
  ) {
    navigationController.isNavigationBarHidden = true
    self.navigationController = navigationController
    self.selectedTab = selectedTab
  }
  
  // MARK: - Methods
  
  public func start() {
    let networkService = NetworkService()
    let memeRepository = MemeRepositoryImpl(networkservice: networkService)
    let userRepository = UserRepositoryImpl(networkservice: networkService)
    
    let getRecommendMemesUseCase = GetRecommendMemesUseCaseImpl(repository: memeRepository)
    let getUserInfoUseCase = GetUserInfoUseCaseImpl(userRepository: userRepository)
    let watchMemeUseCase = WatchMemeUseCaseImpl(repository: memeRepository)
    let reactToMemeUseCase = ReactToMemeUseCaseImpl(repository: memeRepository)
    let bookmarkMemeUseCase = BookmarkMemeUseCaseImpl(repository: memeRepository)
    
    let recommendView = RecommendView(
      RecommendViewModel(
        router: self,
        getRecommendMemesUseCase: getRecommendMemesUseCase,
        getUserInfoUseCase: getUserInfoUseCase,
        watchMemeUseCase: watchMemeUseCase,
        reactToMemeUseCase: reactToMemeUseCase,
        bookmarkMemeUseCase: bookmarkMemeUseCase
      )
    ).tabBar(selectedTab: selectedTab)
    
    setRootView(recommendView)
  }
  
  public func showShareView(items: [Any]) {
    let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
    self.navigationController.present(vc, animated: true)
  }
}
