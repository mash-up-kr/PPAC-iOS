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
  enum MyMemeType: String {
    case recentMeme = "my_recent_meme"
    case savedMeme = "my_saved_meme"
    case uploadedMeme = "my_uploaded_meme"
  }
  
  enum MyPageSegmentedTitle: String {
    case myRegisteredMeme = "내가 올린 밈"
    case mySavedMeme = "나의 파밈함"
  }
  
  public enum Action {
    case onAppearMyPageView
    case pullToRefresh
    case settingButtonTapped
    case onTappedRecentMeme(meme: MemeDetail?)
    case onTappedSavedMeme(meme: MemeDetail?)
    case onTappedCopyButton(meme: MemeDetail?)
    case onTappedSegmentedTitleItem(title: String)
    case onAppearLastMeme
  }

  public struct State {
    var userDetail: UserDetail
    var lastSeenMemeList: [MemeDetail]
    var savedMemeList: [MemeDetail]
    var savedMemePagination: MemeListWithPagination.Pagination
    var registeredMemeList: [MemeDetail]
    var registeredMemePagination: MemeListWithPagination.Pagination
    var isRefreshCompleted: Bool
    var isActiveCopyPopup: Bool
    
    var currentMyMemeList: [MemeDetail]
    var segmentedTitleItems: [SegmentedTitleItem] = []
    var currentSegmentedTitle: MyPageSegmentedTitle
    
    init(
      userDetail: UserDetail,
      lastSeenMemeList: [MemeDetail],
      savedMemeList: [MemeDetail],
      savedMemePagination: MemeListWithPagination.Pagination,
      registeredMemeList: [MemeDetail],
      registeredMemePagination: MemeListWithPagination.Pagination
    ) {
      self.userDetail = userDetail
      self.lastSeenMemeList = lastSeenMemeList
      self.savedMemeList = savedMemeList
      self.savedMemePagination = savedMemePagination
      self.registeredMemeList = registeredMemeList
      self.registeredMemePagination = registeredMemePagination
      self.isRefreshCompleted = true
      self.isActiveCopyPopup = false
      self.currentMyMemeList = registeredMemeList
      self.currentSegmentedTitle = .myRegisteredMeme
      self.segmentedTitleItems = initSegmentedTitleItems()
    }
    
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
    
    var hesNextPageOfRegisteredMeme: Bool {
      return registeredMemePagination.currentPage < registeredMemePagination.totalPages
    }
    
    private func initSegmentedTitleItems() -> [SegmentedTitleItem] {
      return [SegmentedTitleItem(title: MyPageSegmentedTitle.myRegisteredMeme.rawValue, isSelected: true),
              SegmentedTitleItem(title: MyPageSegmentedTitle.mySavedMeme.rawValue, isSelected: false)]
    }
  }
  
  // MARK: - Properties
  weak var router: MyPageRouting?
  @Published public var state: State
  private var userDetail: UserDetail
  private let getUserDetailUseCase: GetUserDetailUseCase
  private let getLastSeenMemeUseCase: GetLastSeenMemeUseCase
  private let getSavedMemeUseCase: GetSavedMemeUseCase
  private let getRegisteredMemeUseCase: GetRegisteredMemeUseCase
  private let copyImageUseCase: CopyImageUseCase
  
  private let memeCountPerPage: Int = 10
  
  // MARK: - Initializers
  
  public init(
    router: MyPageRouting,
    userDetail: UserDetail,
    getUserDetailUseCase: GetUserDetailUseCase,
    getLastSeenMemeUseCase: GetLastSeenMemeUseCase,
    getSavedMemeUseCase: GetSavedMemeUseCase,
    getRegisteredMemeUseCase: GetRegisteredMemeUseCase,
    copyImageUseCase: CopyImageUseCase
  ) {
    self.router = router
    self.state = State(userDetail: userDetail,
                       lastSeenMemeList: [],
                       savedMemeList: [],
                       savedMemePagination: .default,
                       registeredMemeList: [],
                       registeredMemePagination: .default)
    self.userDetail = userDetail
    self.getUserDetailUseCase = getUserDetailUseCase
    self.getLastSeenMemeUseCase = getLastSeenMemeUseCase
    self.getSavedMemeUseCase = getSavedMemeUseCase
    self.getRegisteredMemeUseCase = getRegisteredMemeUseCase
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
        self.logMyPage(event: .meme, meme: meme, type: .recentMeme)
      case .onTappedSavedMeme(let meme):
        self.router?.showMemeDetail(memeDetail: meme)
        self.logMyPageClickMeme(meme: meme)
      case .onTappedCopyButton(let meme):
        await self.copyMemeImage(with: meme)
      case .onTappedSegmentedTitleItem(let title):
        self.selectedSegmentedTitle(title: title)
      case .onAppearLastMeme:
        await self.fetchNextPageMemes()
      }
    }
  }
  
  @MainActor
  private func fetchUserMemes() async {
    do {
      let userDetail = try await self.getUserDetailUseCase.execute()
      let lastSeenMemeList = try await self.getLastSeenMemeUseCase.execute()
      let savedMemeListWithPagination = try await self.getSavedMemeUseCase.execute(page: 1,size: self.memeCountPerPage)
      let registeredMemeListWithPagination = try await self.getRegisteredMemeUseCase.execute(page: 1, size: self.memeCountPerPage)
      
      self.state = State(userDetail: userDetail,
                         lastSeenMemeList: lastSeenMemeList,
                         savedMemeList: savedMemeListWithPagination.memeList,
                         savedMemePagination: savedMemeListWithPagination.pagination,
                         registeredMemeList: registeredMemeListWithPagination.memeList,
                         registeredMemePagination: registeredMemeListWithPagination.pagination)
      
      self.logMyPage(
        interaction: .scroll,
        event: .meme,
        pageCount: state.savedMemePagination.currentPage
      )
      
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
  private func fetchNextPageMemes() async {
    if self.state.currentSegmentedTitle == .myRegisteredMeme {
      await self.fetchNextPageRegisteredMeme()
    } else {
      await self.fetchNextPageSavedMeme()
    }
  }
  
  @MainActor
  private func fetchNextPageSavedMeme() async {
    guard state.hasNextPageOfSavedMeme else { return }
    
    do {
      let savedMemeListWithPagination = try await self.getSavedMemeUseCase
        .execute(
          page: state.savedMemePagination.currentPage + 1,
          size: self.memeCountPerPage
        )
      self.state.savedMemeList += savedMemeListWithPagination.memeList
      self.state.savedMemePagination = savedMemeListWithPagination.pagination
      self.updateCurrentMyMemeList(selectedTitle: .mySavedMeme)
      self.logMyPage(
        interaction: .scroll,
        event: .meme,
        pageCount: state.savedMemePagination.currentPage
      )
      
    } catch(let error) {
      print("fetchNextPageSavedMeme error = \(error)")
    }
  }
  
  @MainActor
  private func fetchNextPageRegisteredMeme() async {
    guard state.hesNextPageOfRegisteredMeme else { return }
    
    do {
      let registeredMemeListWithPagination = try await self.getRegisteredMemeUseCase
        .execute(
          page: self.state.registeredMemePagination.currentPage + 1,
          size: self.memeCountPerPage
        )
      self.state.registeredMemeList += registeredMemeListWithPagination.memeList
      self.state.registeredMemePagination = registeredMemeListWithPagination.pagination
      self.updateCurrentMyMemeList(selectedTitle: .myRegisteredMeme)
      self.logMyPage(
        interaction: .scroll,
        event: .meme,
        pageCount: state.registeredMemePagination.currentPage
      )
      
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
  
  @MainActor
  private func selectedSegmentedTitle(title: String) {
    let segmentedTitle = MyPageSegmentedTitle(rawValue: title)
    self.updateSegmentedTitleItems(selectedTitle: title)
    self.updateCurrentMyMemeList(selectedTitle: segmentedTitle)
    
    if segmentedTitle == .myRegisteredMeme {
      self.logMyPage(event: .tab, type: .uploadedMeme)
    } else {
      self.logMyPage(event: .tab, type: .savedMeme)
    }
  }
  
  @MainActor
  private func updateSegmentedTitleItems(selectedTitle: String) {
    guard let selectedItem = self.state.segmentedTitleItems
      .first(where: { $0.title == selectedTitle }) else { return }

    let newTitleItems = self.state.segmentedTitleItems
      .map {
        SegmentedTitleItem(
          title: $0.title,
          isSelected: $0.title == selectedItem.title
        )
      }
    self.state.segmentedTitleItems = newTitleItems
  }
  
  private func updateCurrentMyMemeList(selectedTitle: MyPageSegmentedTitle?) {
    guard let selectedTitle else { return }
    if selectedTitle == .myRegisteredMeme {
      self.state.currentMyMemeList = self.state.registeredMemeList
      self.state.currentSegmentedTitle = .myRegisteredMeme
    } else {
      self.state.currentMyMemeList = self.state.savedMemeList
      self.state.currentSegmentedTitle = .mySavedMeme
    }
  }
  
  private func logMyPageClickMeme(meme: MemeDetail?) {
    if self.state.currentSegmentedTitle == .myRegisteredMeme {
      self.logMyPage(event: .meme, meme: meme, type: .uploadedMeme)
    } else {
      self.logMyPage(event: .meme, meme: meme, type: .savedMeme)
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
