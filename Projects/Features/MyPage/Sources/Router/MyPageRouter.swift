//
//  MyPageRouter.swift
//  MyPage
//
//  Created by 장혜령 on 2024/07/15.
//

import UIKit
import SwiftUI

import PPACUtil
import PPACModels
import PPACDomain
import PPACNetwork
import PPACData

public final class MyPageRouter: Router, MyPageRouting {
  // MARK: - Properties
  public var delegate: (any RouterDelegate)?
  public var navigationController: UINavigationController
  
  public var childRouters: [any Router] = []
  
  private let userDetail: UserDetail
  
  
  // MARK: - Initializers
  public init(navigationController: UINavigationController, userDetail: UserDetail) {
    self.navigationController = navigationController
    self.userDetail = userDetail
    
    self.navigationController = self.createNavigationController()
  }
  
  // MARK: - Methods
  public func createNavigationController() -> UINavigationController {
    let repository = UserRepositoryImpl(networkservice: NetworkService())
    
    let myPageView = MyPageView(
      viewModel: MyPageViewModel(
        userDetail: self.userDetail,
        getUserDetailUseCase: GetUserDetailUseCaseImpl(userRepository: repository),
        getLastSeenMemeUseCase: GetLastSeenMemeUseCaseImpl(userRepository: repository),
        getSavedMemeUseCase: GetSavedMemeUseCaseImpl(userRepository: repository)
      )
    )
    
    let viewController = UIHostingController(rootView: myPageView)
    return UINavigationController(rootViewController: viewController)
  }

  public func start() { }
  
  public func showSettingView() { }
  
}

