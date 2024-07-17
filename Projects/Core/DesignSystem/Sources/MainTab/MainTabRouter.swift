//
//  MainTabRouter.swift
//  Home
//
//  Created by 장혜령 on 2024/07/11.
//

import UIKit
import SwiftUI

import PPACUtil
import PPACModels
import MyPage

public final class MainTabRouter: Router, MainTabRouting {
  
  // MARK: - Properties
  public var delegate: (any RouterDelegate)?
  public let tabBarController = UITabBarController()
  public var navigationController: UINavigationController
  
  public var childRouters: [any Router] = []
  
  public var userDetail: UserDetail
  
  // MARK: - Initializers
  
  public init(
    _ navigationController: UINavigationController,
    userDetail: UserDetail
  ){
    self.navigationController = navigationController
    self.userDetail = userDetail
    self.tabBarController.viewControllers = []
  }
  
  // MARK: - Methods
  public func start() {
    let myPage = getMyPageViewController()
    let myPage2 = getMyPageViewController()
    let myPage3 = getMyPageViewController()
//    showMyPageView()
//    showMyPageView()
//    showMyPageView()
//    let vc1 = getMyPageView()
//    let vc2 = getMyPageView()
//    let vc3 = getMyPageView()
    self.tabBarController.viewControllers = [myPage, myPage2, myPage3]
    self.navigationController.pushViewController(tabBarController, animated: true)
  }

  public func showRecommendView(userDetail: UserDetail) {}
  
  public func showSearchView() {}
  
  public func showMyPageView() {
    let myPageRouter = MyPageRouter(navigationController: self.navigationController,
                                    userDetail: self.userDetail)
    //self.childRouters.append(myPageRouter)
    myPageRouter.start()
  }
  
  public func getMyPageViewController() -> UIViewController {
    let myPageRouter = MyPageRouter(navigationController: self.navigationController,
                                    userDetail: self.userDetail)
    let viewController = myPageRouter.createNavigationController()
    let tabItem = self.getTabBarItem(with: .mypage)
    viewController.tabBarItem = tabItem
    self.childRouters.append(myPageRouter)
    return viewController
  }
  
  private func getTabBarItem(with type: MainTab) -> UITabBarItem {
    return UITabBarItem(
      title: type.title,
      image: type.uiImage,
      selectedImage: type.selectedUIImage
    )
  }
}
