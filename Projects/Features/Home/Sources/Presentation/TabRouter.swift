//
//  TabRouter.swift
//  Home
//
//  Created by kimchansoo on 7/17/24.
//

import UIKit
import SwiftUI
import Combine

import Recommend
import Search
import MyPage
import PPACUtil
import DesignSystem

import MemeDetail

public protocol TabRouterDelegate: AnyObject {
    func didFinish(childRouter: Router)
}

public final class MainTabRouter: Router, ObservableObject {
  
  public var delegate: (any PPACUtil.RouterDelegate)?
  public var navigationController: UINavigationController
  public var childRouters: [Router] = []
  private var cancellables: Set<AnyCancellable> = []
  
  @Published private var selectedTab: MainTab = .recommend
  
  private var selectedTabBinding: Binding<MainTab> {
    Binding(
      get: { self.selectedTab },
      set: { self.selectedTab = $0 }
    )
  }
  
  public init(navigationController: UINavigationController) {
    print("MainTabRouter init")
    self.navigationController = navigationController
  }
  
  public func start() {
    setupTabChangeListener()
  }
  
  public func switchToTab(_ tab: MainTab) {
    print("switchToTab: \(tab)")
    childRouters = []
    switch tab {
    case .recommend:
      let recommendRouter = RecommendRouter(self.navigationController, selectedTab: selectedTabBinding)
      childRouters.append(recommendRouter)
      recommendRouter.start()
    case .search:
      // sample
      let detailRouter = MemeDetailRouter(self.navigationController, meme: .mock)
      childRouters.append(detailRouter)
      detailRouter.start()
    case .mypage:
      fatalError()
    }
  }
  
  private func setupTabChangeListener() {
    $selectedTab
//      .removeDuplicates()
      .sink { [weak self] newTab in
        self?.switchToTab(newTab)
      }
      .store(in: &cancellables)
  }
}
