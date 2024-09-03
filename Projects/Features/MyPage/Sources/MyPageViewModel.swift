//
//  MyPageViewModel.swift
//  MyPage
//
//  Created by 장혜령 on 2024/07/15.
//

import SwiftUI

import PPACUtil
import PPACDomain
import PPACModels
import PPACAnalytics

@MainActor
public protocol MyPageRouting: AnyObject {
  func showSettingView()
  func showMemeDetail(memeDetail: MemeDetail?)
}

final public class MyPageViewModel: ViewModelType, ObservableObject {
  
  // 트래킹을 위해 추가한 type
  public enum MyMemeType: String {
    case recentMeme = "my_recent_meme"
    case savedMeme = "my_saved_meme"
  }
  
  public enum Action {
    case onAppearMyPageView
    case pullToRefresh
    case settingButtonTapped
    case onTappedRecentMeme(meme: MemeDetail?)
    case onTappedSavedMeme(meme: MemeDetail?)
    case onTappedCopyButton(meme: MemeDetail?)
    case onAppearLastMeme
  }

  public struct State {
    var userDetail: UserDetail
    var lastSeenMemeList: [MemeDetail]
    var savedMemeList: [MemeDetail]
    var savedMemePagination: MemeListWithPagination.Pagination
    var isRefreshCompleted: Bool = true
    var isActiveCopyPopup: Bool = false
    
    var memeLevel: MemeLevelType {
      return MemeLevelType(rawValue: userDetail.level) ?? .level1
    }
    
    var conditionCount: Int {
      switch memeLevel {
      case .level1:
        userDetail.watch
      case .level2:
        userDetail.reaction
      case .level3:
        userDetail.share
      case .level4:
        userDetail.save
      }
    }
    
    var hasNextPageOfSavedMeme: Bool {
      return savedMemePagination.currentPage < savedMemePagination.totalPages
    }
  }
  
  // MARK: - Properties
  weak var router: MyPageRouting?
  @Published public var state: State
  private var userDetail: UserDetail
  private let getUserDetailUseCase: GetUserDetailUseCase
  private let getLastSeenMemeUseCase: GetLastSeenMemeUseCase
  private let getSavedMemeUseCase: GetSavedMemeUseCase
  private let copyImageUseCase: CopyImageUseCase
  
  private var currentPage: Int = 1
  private let savedMemeCountPerPage: Int = 10
  
  // MARK: - Initializers
  
  public init(
    router: MyPageRouting,
    userDetail: UserDetail,
    getUserDetailUseCase: GetUserDetailUseCase,
    getLastSeenMemeUseCase: GetLastSeenMemeUseCase,
    getSavedMemeUseCase: GetSavedMemeUseCase,
    copyImageUseCase: CopyImageUseCase
  ) {
    self.router = router
    self.state = State(userDetail: userDetail,
                       lastSeenMemeList: [],
                       savedMemeList: [],
                       savedMemePagination: .none)
    self.userDetail = userDetail
    self.getUserDetailUseCase = getUserDetailUseCase
    self.getLastSeenMemeUseCase = getLastSeenMemeUseCase
    self.getSavedMemeUseCase = getSavedMemeUseCase
    self.copyImageUseCase = copyImageUseCase
  }
  
  // MARK: - Methods
  public func dispatch(type: Action) {
    Task { @MainActor in
      switch type {
      case .onAppearMyPageView:
        await self.fetchUserMemes()
      case .pullToRefresh:
        await self.refreshUserMemes()
      case .settingButtonTapped:
        self.router?.showSettingView()
        self.logMyPage(event: .settings)
      case .onTappedRecentMeme(let meme):
        self.router?.showMemeDetail(memeDetail: meme)
        self.logMyPage(event: .meme, type: .recentMeme)
      case .onTappedSavedMeme(let meme):
        self.router?.showMemeDetail(memeDetail: meme)
        self.logMyPage(event: .meme, type: .savedMeme)
      case .onTappedCopyButton(let meme):
        await self.copyMemeImage(with: meme)
      case .onAppearLastMeme:
        await self.fetchNextPageSavedMeme()
      }
    }
  }
  
  @MainActor
  private func fetchUserMemes() async {
    do {
      let userDetail = try await self.getUserDetailUseCase.execute()
      let lastSeenMemeList = try await self.getLastSeenMemeUseCase.execute()
      let savedMemeListWithPagination = try await self.getSavedMemeUseCase.execute(page: 1,
                                                                     size: self.savedMemeCountPerPage)
      self.state = State(userDetail: userDetail,
                         lastSeenMemeList: lastSeenMemeList,
                         savedMemeList: savedMemeListWithPagination.memeList,
                         savedMemePagination: savedMemeListWithPagination.pagination)
    } catch(let error) {
      print("fetchUserMemes error = \(error)")
    }
  }
  
  @MainActor
  private func refreshUserMemes() async {
    self.state.isRefreshCompleted = false
    await fetchUserMemes()
  }
  
  @MainActor
  private func fetchNextPageSavedMeme() async {
    guard state.hasNextPageOfSavedMeme else { return }
    
    do {
      let savedMemeListWithPagination = try await self.getSavedMemeUseCase
        .execute(
          page: state.savedMemePagination.currentPage + 1,
          size: self.savedMemeCountPerPage
        )
      // self.logMyPage(interaction: .scroll, event: .meme) // TODO: pageCount 추가 어떻게 할지
      self.state.savedMemeList += savedMemeListWithPagination.memeList
      self.state.savedMemePagination = savedMemeListWithPagination.pagination
    } catch(let error) {
      print("fetchNextPageSavedMeme error = \(error)")
    }
  }
  
  @MainActor
  private func copyMemeImage(with meme: MemeDetail?) async {
    guard let meme else { return }
    do {
      try await self.copyImageUseCase.execute(url: meme.imageUrlString)
      self.state.isActiveCopyPopup = true
      self.logMyPage(event: .copy, meme: meme)
    } catch {
      print("복사 실패")
    }
  }
  
  func logMyPage(
    interaction: PPACAnalytics.UserInteraction = .click,
    event: PPACAnalytics.UserEvent,
    meme: MemeDetail? = nil,
    type: MyMemeType? = nil,
    pageCount: Int? = nil
  ) {
    
    var parameters: [String: Any] = [:]
    
    if let type {
      parameters["content_type"] = type.rawValue
    }
    
    if let pageCount {
      parameters["page_count"] = pageCount
    }
    
    PPACAnalytics.shared
      .log(
        interaction: interaction,
        event: event,
        page: .myPage,
        memeId: meme?.id,
        memeTitle: meme?.title,
        extraParameters: parameters
      )
    
  }

}
