//
//  SplashRouter.swift
//  Home
//
//  Created by 장혜령 on 2024/07/11.
//

import UIKit
import SwiftUI

import PPACUtil
import PPACNetwork
import PPACData
import PPACDomain

public final class SplashRouter: Router, SplashRouting {
  
  // MARK: - Properties
  public var delegate: (any RouterDelegate)?
  
  public var navigationController: UINavigationController
  
  public var childRouters: [any Router] = []
  
  // MARK: - Initializers
  
  public init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: - Methods
  public func start() {
    let repository = UserRepositoryImpl(networkservice: NetworkService())
    let useCase = CheckUserUseCaseImpl(userRepository: repository)
    self.pushView(
      SplashView(
        viewModel: SplashViewModel(
          router: self,
          checkUserUseCase: useCase
        )
      )
    )
  }
  
  public func showMainTabView(userDetail: UserDetail) {
    let mainTabRouter = MainTabRouter(self.navigationController,
                                      userDetail: userDetail)
    self.childRouters.append(mainTabRouter)
    mainTabRouter.start()
  }
  
}
