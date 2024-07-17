//
//  MainTabViewModel.swift
//  Home
//
//  Created by 장혜령 on 7/16/24.
//

import SwiftUI

import PPACModels
import PPACUtil

@MainActor
public protocol MainTabRouting: AnyObject {
  func showRecommendView(userDetail: UserDetail)
  func showSearchView()
  func showMyPageView()
}

final public class MainTabViewModel: ViewModelType, ObservableObject {
  
  public enum Action { }
  
  public struct State {
    var selectedTab: MainTab
  }
  
  // MARK: - Properties
  weak var router: (MainTabRouting)?
  @Published public var state: State
  
  // MARK: - Initializers
  init(router: MainTabRouting) {
    self.router = router
    self.state = State(selectedTab: .recommend)
  }
  
  // MARK: - Methods
  
  public func dispatch(type: Action) { }
  
  public func getTabViews() {
    
  }
  
  
  
//  func selectTab(_ tab: MainTab) {
//    self.state.selectedTab = tab
//    switch tab {
//    case .recommend:
//      self.router.showRecommendView(userDetail: router?.userDetail ?? UserDetail())
//    case .search:
//      self.router.showSearchView()
//    case .mypage:
//      self.router.showMyPageView()
//    }
//  }
}
