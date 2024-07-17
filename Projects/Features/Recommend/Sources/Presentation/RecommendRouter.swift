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

public final class RecommendRouter: Router {
  
  // MARK: - Properties
  
  public var delegate: (any RouterDelegate)?
  
  public var navigationController: UINavigationController
  
  public var childRouters: [any Router] = []
  private var selectedTab: Binding<MainTab>
  
  // MARK: - Initializers
  
  public init(_ navigationController: UINavigationController, selectedTab: Binding<MainTab>) {
    navigationController.isNavigationBarHidden = true
    self.navigationController = navigationController
    self.selectedTab = selectedTab
  }
  
  // MARK: - Methods
  
  public func start() {
    let networkService = NetworkService()
    let memeRepository = MemeRepositoryImpl(networkservice: networkService)
    let userRepository = UserRepositoryImpl(networkservice: networkService)
    
    let getRecommendMemesUseCase = GetRecommendMemesUseCaseImpl(
      repository: memeRepository
    )
    let getUserInfoUseCase = GetUserInfoUseCaseImpl(userRepository: userRepository)
    
    self.pushView(
      RecommendView(
        RecommendViewModel(
          router: self,
          getRecommendMemesUseCase: getRecommendMemesUseCase,
          getUserInfoUseCase: getUserInfoUseCase
        )
      )
    )
  }
}
