//
//  SearchResultRouter.swift
//  Search
//
//  Created by 리나 on 7/13/24.
//

import UIKit
import SwiftUI

import PPACUtil
import PPACModels
import PPACData
import PPACNetwork
import PPACDomain
import DesignSystem
import MemeDetail

public final class SearchResultRouter: Router, SearchResultRouting {
  
  // MARK: - Properties
  public var delegate: (any RouterDelegate)?
  public var navigationController: UINavigationController
  public var childRouters: [any Router] = []
  
  let keyword: String
  let text: String

  // MARK: - Initializers
  
  public init(_ navigationController: UINavigationController, keyword: String, text: String) {
    navigationController.isNavigationBarHidden = true
    self.navigationController = navigationController
    self.keyword = keyword
    self.text = text
  }
  
  // MARK: - Methods
  
  public func start() {
    let repository = MemeRepositoryImpl(networkservice: NetworkService())

    self.pushView(
      SearchResultView(viewModel: SearchResultViewModel(
        keyword: keyword,
        text: text,
        router: self,
        searchKeywordUseCase: SearchKeywordUseCaseImpl(repository: repository),
        searchByTextUseCase: SearchByTextUseCaseImpl(repository: repository),
        copyImageUseCase: CopyImageUseCaseImpl(),
        watchMemeUseCase: WatchMemeUseCaseImpl(repository: repository)
      ))
    )
  }
  
  public func showMemeDetail(memeDetail: MemeDetail) {
    let router = MemeDetailRouter(self.navigationController, meme: memeDetail)
    self.childRouters.append(router)
    router.start()
  }
}
