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

public final class SplashRouter: Router, SplachRouting {
  
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
    let useCase = CreateUserUseCaseImpl(userRepository: repository)
    self.pushView(
      SplashView(
        viewModel: SplashViewModel(
          router: self,
          createUserUserCase: useCase
        )
      )
    )
  }
  
  public func showMainTabView() {
    let mainTabRouter = MainTabRouter(self.navigationController)
    self.childRouters.append(mainTabRouter)
    mainTabRouter.start()
  }
  
}
