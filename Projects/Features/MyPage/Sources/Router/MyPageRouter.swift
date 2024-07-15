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

public final class MyPageRouter: Router, MyPageRouting {
  // MARK: - Properties
  public var delegate: (any RouterDelegate)?
  
  public var navigationController: UINavigationController
  
  public var childRouters: [any Router] = []
  
  private let userDetail: UserDetail
  
  // MARK: - Initializers
  
  public init(_ navigationController: UINavigationController, userDetail: UserDetail) {
    self.navigationController = navigationController
    self.userDetail = userDetail
  }
  
  // MARK: - Methods
  
  public func start() {
    let repository = UserRepositoryImpl(networkservice: NetworkService())
    let getUserDetailUseCase = GetUserDetailUseCaseImpl(userRepository: repository)
    let getLastSeenMemeUseCase = GetLastSeenMemeUseCaseImpl(userRepository: repository)
    let getSavedMemeUseCase = GetSavedMemeUseCaseImpl(userRepository: repository)
    
    self.pushView(
      MyPageView(
        viewModel: MyPageViewModel(
          userDetail: self.userDetail,
          getUserDetailUseCase: getUserDetailUseCase,
          getLastSeenMemeUseCase: getLastSeenMemeUseCase,
          getSavedMemeUseCase: getSavedMemeUseCase
        )
      )
    )
  }
  
  public func showSettingView() { }
}
