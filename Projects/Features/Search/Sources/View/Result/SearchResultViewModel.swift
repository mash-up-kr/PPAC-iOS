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
import MemeDetail

@MainActor
public protocol SearchResultRouting: AnyObject {
  func popView()
  func showMemeDetail(memeDetail: MemeDetail)
}

public final class SearchResultViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case viewWillAppear
    case memeDetailTapped(meme: MemeDetail)
    case memeCopyTapped(meme: MemeDetail)
    case naviBackButtonTapped
  }
  
  public struct State {
    var keyword: String
    var memeList: [MemeDetail]
    var isActiveCopyPopup: Bool = false
  }
  
  // MARK: - Properties
  
  weak var router: SearchResultRouting?
  @Published public var state: State
  
  private let searchKeywordUseCase: SearchKeywordUseCase
  private let copyImageUseCase: CopyImageUseCase

  // MARK: - Initializers
  
  public init(
    keyword: String,
    router: SearchResultRouting?,
    searchKeywordUseCase: SearchKeywordUseCase,
    copyImageUseCase: CopyImageUseCase
  ) {
    self.router = router
    self.state = State(keyword: keyword, memeList: [])
    self.searchKeywordUseCase = searchKeywordUseCase
    self.copyImageUseCase = copyImageUseCase
  }
  
  // MARK: - Methods
  
  @MainActor
  public func dispatch(type: Action) {
    Task { @MainActor in
      switch type {
      case .viewWillAppear:
        await fetchData()
      case .memeDetailTapped(let meme):
        router?.showMemeDetail(memeDetail: meme)
      case .memeCopyTapped(let meme):
        await copyImage(urlString: meme.imageUrlString)
        break
      case .naviBackButtonTapped:
        router?.popView()
      }
    }
  }
  
  @MainActor
  private func fetchData() async {
    do {
      state.memeList = try await searchKeywordUseCase.execute(keyword: state.keyword)
    } catch(let error) {
      debugPrint("error = \(error)")
    }
  }
  
  @MainActor
  private func copyImage(urlString: String) async {
    do {
      try await copyImageUseCase.execute(url: urlString)
      state.isActiveCopyPopup = true
    } catch(let error) {
      debugPrint("error = \(error)")
    }
  }
}
