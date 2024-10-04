//
//  SearchResultViewModel.swift
//  Search
//
//  Created by 리나 on 7/13/24.
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
public protocol SearchResultRouting: AnyObject {
  func popView()
  func showMemeDetail(memeDetail: MemeDetail)
}

public final class SearchResultViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case viewWillAppear
    case refresh
    case search(text: String)
    case memeDetailTapped(meme: MemeDetail)
    case memeCopyTapped(meme: MemeDetail)
    case naviBackButtonTapped
    case onAppearLastMeme
  }
  
  public struct State {
    var keyword: String
    var text: String
    var memeList: [MemeDetail]
    var memePagination: MemeListWithPagination.Pagination
    var isActiveCopyPopup: Bool = false
    var isLoading: Bool = true
  }
  
  // MARK: - Properties
  
  weak var router: SearchResultRouting?
  @Published public var state: State
  
  private let searchKeywordUseCase: SearchKeywordUseCase
  private let searchByTextUseCase: SearchByTextUseCase
  private let copyImageUseCase: CopyImageUseCase
  private let watchMemeUseCase: WatchMemeUseCase

  // MARK: - Initializers
  
  public init(
    keyword: String,
    text: String,
    router: SearchResultRouting?,
    searchKeywordUseCase: SearchKeywordUseCase,
    searchByTextUseCase: SearchByTextUseCase,
    copyImageUseCase: CopyImageUseCase,
    watchMemeUseCase: WatchMemeUseCase
  ) {
    self.router = router
    self.state = State(
      keyword: keyword,
      text: text,
      memeList: [],
      memePagination: .default
    )
    self.searchKeywordUseCase = searchKeywordUseCase
    self.searchByTextUseCase = searchByTextUseCase
    self.copyImageUseCase = copyImageUseCase
    self.watchMemeUseCase = watchMemeUseCase
  }
  
  // MARK: - Methods
  
  @MainActor
  public func dispatch(type: Action) {
    Task { @MainActor in
      switch type {
      case .viewWillAppear:
        await fetchData()
      case .refresh:
        if state.text.isEmpty == false {
          await fetchData(with: state.text)
        } else if state.keyword.isEmpty == false {
          await fetchData(with: state.keyword)
        }
        
      case .search(text: let text):
        await fetchData(with: text)
      case .memeDetailTapped(let meme):
        router?.showMemeDetail(memeDetail: meme)
        logSearch(event: .meme, keyword: state.keyword)
        await postShownMeme(memeId: meme.id)
      case .memeCopyTapped(let meme):
        await copyImage(meme: meme)
        break
      case .naviBackButtonTapped:
        router?.popView()
      case .onAppearLastMeme:
        await fetchData()
      }
    }
  }
  
  @MainActor
  private func fetchData(with newText: String = "") async {
    do {
      if newText.isEmpty == false {
        state.text = newText
        state.keyword = ""
        state.memeList = []
        state.memePagination.currentPage = -1
      }
      
      guard state.memePagination.currentPage < state.memePagination.totalPages
      else {
        return
      }
      state.isLoading = true
      
      if state.text.isEmpty == false {
        let result = try await searchByTextUseCase
          .execute(
            page: state.memePagination.currentPage + 1,
            size: state.memePagination.perPageOfMemes,
            text: state.text
          )
        
        state.memeList += result.memeList
        state.memePagination = result.pagination
        state.isLoading = false

      } else if state.keyword.isEmpty == false {
        let result = try await searchKeywordUseCase
          .execute(
            page: state.memePagination.currentPage + 1,
            size: state.memePagination.perPageOfMemes,
            keyword: state.keyword
          )
        
        state.memeList += result.memeList
        state.memePagination = result.pagination
        state.isLoading = false
      }
      
      self.logSearch(
        interaction: .scroll,
        event: .meme,
        pageCount: state.memePagination.currentPage
      )

    } catch(let error) {
      debugPrint("error = \(error)")
    }
  }
  
  @MainActor
  private func copyImage(meme: MemeDetail) async {
    do {
      try await copyImageUseCase.execute(url: meme.imageUrlString)
      state.isActiveCopyPopup = true
      logSearch(event: .copy, meme: meme)
    } catch(let error) {
      debugPrint("error = \(error)")
    }
  }
  
  @MainActor
  func postShownMeme(memeId: String?) async {
    guard let memeId else { return }
    do {
      try await watchMemeUseCase.execute(memeId: memeId, type: "search")
    } catch {
      debugPrint("Failed show recommnedMeme : \(error)")
    }
  }

  func logSearch(
    interaction: PPACAnalytics.UserInteraction = .click,
    event: PPACAnalytics.UserEvent,
    keyword: String? = nil,
    pageCount: Int? = nil,
    meme: MemeDetail? = nil
  ) {
    var parameters: [String: Any] = [:]
    
    if let keyword {
      parameters["keyword_name"] = keyword
    }
    
    if let pageCount {
      parameters["page_count"] = pageCount
    }
    
    PPACAnalytics.shared
      .log(interaction: interaction,
           event: event,
           page: .searchDetail,
           memeId: meme?.id,
           memeTitle: meme?.title,
           extraParameters: parameters
      )
  }
}
