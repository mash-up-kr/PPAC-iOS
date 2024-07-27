//
//  SearchRouter.swift
//  Search
//
//  Created by 리나 on 7/17/24.
//

import UIKit
import SwiftUI

import PPACUtil
import PPACModels
import PPACData
import PPACDomain
import PPACNetwork
import DesignSystem

public final class SearchRouter: Router, SearchRouting {
  
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
    let repository = KeywordRepositoryImpl(networkService: NetworkService())

    let view = SearchView(
      viewModel: SearchViewModel(
        router: self,
        hotKeywordsUseCase: HotKeywordsUseCaseImpl(repository: repository),
        memeCategorysUseCase: MemeCategorysUseCaseImpl(repository: repository)
      )
    ).tabBar(selectedTab: selectedTab)
    setRootView(view)
  }
  
  public func showSearchResult(keyword: String) {
    let router = SearchResultRouter(self.navigationController, keyword: keyword)
    self.childRouters.append(router)
    router.start()
  }
}
