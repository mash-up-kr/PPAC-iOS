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

@MainActor
public protocol MyPageRouting: AnyObject {
  func showSettingView()
  func showMemeDetail(memeDetail: MemeDetail?)
}

final public class MyPageViewModel: ViewModelType, ObservableObject {
  
  
  public enum Action {
    case onAppearMyPageView
    case pullToRefresh
    case settingButtonTapped
    case onTappedMeme
    case onTappedCopyButton
    case onAppearLastMeme
  }
  
  public struct Handler {
    var memeClickHandler: ((MemeDetail) -> ())?
    var memeCopyHandler: ((MemeDetail) -> ())?
    var onAppearLastMemeHandler: (() -> ())?
    static let none = Handler()
  }
  
  public struct State {
    var userDetail: UserDetail
    var lastSeenMemeList: [MemeDetail]
    var savedMemeList: [MemeDetail]
    var savedMemePagination: MemeListWithPagination.Pagination
    var isRefreshCompleted: Bool
    
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
  public var handler: Handler = .none
  
  private var currentPage: Int = 1
  private let savedMemeCountPerPage: Int = 2
  
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
                       savedMemePagination: .none,
                       isRefreshCompleted: true)
    self.userDetail = userDetail
    self.getUserDetailUseCase = getUserDetailUseCase
    self.getLastSeenMemeUseCase = getLastSeenMemeUseCase
    self.getSavedMemeUseCase = getSavedMemeUseCase
    self.copyImageUseCase = copyImageUseCase
    
    self.initHandler()
  }
  
  // MARK: - Methods
  public func dispatch(type: Action) { }
  
  public func dispatch(type: Action, memeDetail: MemeDetail? = nil) {
    Task { @MainActor in
      switch type {
      case .onAppearMyPageView:
        await self.fetchUserMemes()
      case .pullToRefresh:
        await self.refreshUserMemes()
      case .settingButtonTapped:
        router?.showSettingView()
      case .onTappedMeme:
        await self.router?.showMemeDetail(memeDetail: memeDetail)
      case .onTappedCopyButton:
        await self.copyMemeImage(with: memeDetail?.imageUrlString)
      case .onAppearLastMeme:
        await self.fetchNextPageSavedMeme()
      }
    }
  }
  
  private func initHandler() {
    let memeClickHandler: ((MemeDetail) -> ()) = { [weak self] memeDetail in
      guard let self else { return }
      Task {
        await self.router?.showMemeDetail(memeDetail: memeDetail)
      }
    }
    
    let memeCopyHandler: ((MemeDetail) -> ()) = { [weak self] memeDetail in
      guard let self else { return }
      Task {
        print("memeCopyHandler \(memeDetail.title)")
        do {
          try await self.copyImageUseCase.execute(url: memeDetail.imageUrlString)
        } catch {
          print("복사 실패")
        }
      }
    }
    
    let onAppearLastMemeHandler: (() -> ()) = { [weak self] in
      guard let self else { return }
      Task {
        await self.fetchNextPageSavedMeme()
      }
    }
    
    self.handler = Handler(
      memeClickHandler: memeClickHandler,
      memeCopyHandler: memeCopyHandler,
      onAppearLastMemeHandler: onAppearLastMemeHandler
    )
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
                         savedMemePagination: savedMemeListWithPagination.pagination,
                         isRefreshCompleted: true)
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
      
      self.state.savedMemeList += savedMemeListWithPagination.memeList
      self.state.savedMemePagination = savedMemeListWithPagination.pagination
    } catch(let error) {
      print("fetchNextPageSavedMeme error = \(error)")
    }
  }
  
  @MainActor
  private func copyMemeImage(with url: String?) async {
    do {
      //guard let url else { }
      try await self.copyImageUseCase.execute(url: url ?? "")
    } catch {
      print("복사 실패")
    }
  }

}
