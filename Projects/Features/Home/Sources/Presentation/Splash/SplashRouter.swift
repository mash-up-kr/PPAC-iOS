//
//  SplashRouter.swift
//  Home
//
//  Created by 장혜령 on 2024/07/11.
//

import UIKit
import SwiftUI
import Combine

import PPACUtil
import PPACNetwork
import PPACData
import PPACDomain
import PPACModels

public final class SplashRouter: Router, SplashRouting {
  
  // MARK: - Properties
  public var delegate: (any RouterDelegate)?
  
  public var navigationController: UINavigationController
  
  public var childRouters: [any Router] = []
  
  private let deeplinkMemeId: PassthroughSubject<String, Never>
  
  // MARK: - Initializers
  
  public init(_ navigationController: UINavigationController, deeplinkMemeId: PassthroughSubject<String, Never>) {
    self.navigationController = navigationController
    self.deeplinkMemeId = deeplinkMemeId
  }
  
  // MARK: - Methods
  public func start() {
    let repository = UserRepositoryImpl(networkservice: NetworkService())
    let useCase = CheckUserInfoUseCaseImpl(userRepository: repository)
    self.pushView(
      SplashView(
        viewModel: SplashViewModel(
          router: self,
          checkUserInfoUseCase: useCase
        )
      )
    )
  }
  
  public func showMainTabView(userDetail: UserDetail) {
    let mainTabRouter = MainTabRouter(
      navigationController: self.navigationController,
      userDetail: userDetail,
      deepLinkMemeId: deeplinkMemeId
    )
    self.childRouters.append(mainTabRouter)
    mainTabRouter.start()
  }
  
}
