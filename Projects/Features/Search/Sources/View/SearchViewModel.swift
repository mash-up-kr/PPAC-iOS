//
//  SearchViewModel.swift
//  Search
//
//  Created by 리나 on 7/18/24.
//

import UIKit
import Dependencies

import PPACUtil
import PPACModels
import PPACDomain
import PPACNetwork
import PPACData
import PPACAnalytics

import MemeDetail

@MainActor
public protocol SearchRouting: AnyObject {
  func showSearchResult(keyword: String)
}

public final class SearchViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case viewWillAppear
    case searchBarTapped
    case dismissSearchBarAlert
    case hotKeywordTapped(keyword: String)
    case recommendKeywordTapped(keyword: String)
  }
  
  public struct State {
    var hotKeywords: [HotKeyword]
    var memeCategories: [MemeCategory]
    var isPresenting: Bool = false
    var isLoading: Bool = true
  }
  
  // MARK: - Properties
  
  weak var router: SearchRouting?
  @Published public var state: State
  
  private let hotKeywordsUseCase: HotKeywordsUseCase
  private let memeCategorysUseCase: MemeCategorysUseCase
  
  // MARK: - Initializers
  
  public init(
    router: SearchRouting?,
    hotKeywordsUseCase: HotKeywordsUseCase,
    memeCategorysUseCase: MemeCategorysUseCase
  ) {
    self.router = router
    self.state = State(hotKeywords: [], memeCategories: [])
    self.hotKeywordsUseCase = hotKeywordsUseCase
    self.memeCategorysUseCase = memeCategorysUseCase
  }
  
  // MARK: - Methods
  
  @MainActor
  public func dispatch(type: Action) {
    Task { @MainActor in
      switch type {
      case .viewWillAppear:
        await fetchData()
      case .searchBarTapped:
        state.isPresenting = true
        logSearch(event: .searchBar)
      case .dismissSearchBarAlert:
        state.isPresenting = false
      case .hotKeywordTapped(let keyword):
        router?.showSearchResult(keyword: keyword)
        logSearch(event: .hotKeyword, keyword: keyword)
      case .recommendKeywordTapped(let keyword):
        router?.showSearchResult(keyword: keyword)
      }
    }
  }
  
  @MainActor
  func fetchData() async {
    guard state.hotKeywords == [] || state.memeCategories == [] else { return }
    state.isLoading = true
    do {
      state.hotKeywords = try await hotKeywordsUseCase.execute()
      state.memeCategories = try await memeCategorysUseCase.execute()
      state.isLoading = false
    } catch(let error) {
      debugPrint("error = \(error)")
    }
  }
  
  func logSearch(
    event: PPACAnalytics.UserEvent,
    keyword: String? = nil,
    category: String? = nil
  ) {
    var parameters: [String: Any] = [:]
    
    if let keyword {
      parameters["keyword_name"] = keyword
    }
    
    if let category {
      parameters["category"] = category
    }
    
    PPACAnalytics.shared
      .log(interaction: .click,
           event: event,
           page: .search,
           extraParameters: parameters
      )
  }
}
