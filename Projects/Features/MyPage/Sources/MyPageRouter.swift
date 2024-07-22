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

import MemeDetail
import DesignSystem
import Setting

public final class MyPageRouter: Router, MyPageRouting {
  
  // MARK: - Properties
  public var delegate: (any RouterDelegate)?
  public var navigationController: UINavigationController
  public var childRouters: [any Router] = []
  private var selectedTab: Binding<MainTab>
  private let userDetail: UserDetail
  
  // MARK: - Initializers
  public init(
    navigationController: UINavigationController,
    selectedTab: Binding<MainTab>,
    userDetail: UserDetail
  ) {
    self.navigationController = navigationController
    self.selectedTab = selectedTab
    self.userDetail = userDetail
  }
  
  // MARK: - Methods
  public func start() { 
    let repository = UserRepositoryImpl(networkservice: NetworkService())
    
    let myPageView = MyPageView(
      viewModel: MyPageViewModel(
        router: self,
        userDetail: self.userDetail,
        getUserDetailUseCase: GetUserDetailUseCaseImpl(userRepository: repository),
        getLastSeenMemeUseCase: GetLastSeenMemeUseCaseImpl(userRepository: repository),
        getSavedMemeUseCase: GetSavedMemeUseCaseImpl(userRepository: repository),
        copyImageUseCase: CopyImageUseCaseImpl()
      )
    ).tabBar(selectedTab: selectedTab)
    
    self.setRootView(myPageView)
  }
  
  public func showMemeDetail(memeDetail: MemeDetail) {
    let router = MemeDetailRouter(self.navigationController, meme: memeDetail)
    self.childRouters.append(router)
    router.start()
  }
  
  public func showSettingView() { 
    let router = SettingRouter(navigationController: self.navigationController)
    self.childRouters.append(router)
    router.start()
  }
  
}

