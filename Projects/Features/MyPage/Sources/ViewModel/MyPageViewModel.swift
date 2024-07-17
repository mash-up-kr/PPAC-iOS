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
  func showMemeDetail(memeDetail: MemeDetail)
}

final public class MyPageViewModel: ViewModelType, ObservableObject {
  
  public enum Action { }
  
  public struct Handler {
    var memeClickHandler: ((MemeDetail) -> ())?
    var memeCopyHandler: ((MemeDetail) -> ())?
    
    static let none = Handler(memeClickHandler: nil)
  }
  
  public struct State {
    var userDetail: UserDetail
    var lastSeenMemeList: [MemeDetail]
    var savedMemeList: [MemeDetail]
    
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
  }
  
  // MARK: - Properties
  weak var router: MyPageRouting?
  @Published public var state: State
  private var userDetail: UserDetail
  private let getUserDetailUseCase: GetUserDetailUseCase
  private let getLastSeenMemeUseCase: GetLastSeenMemeUseCase
  private let getSavedMemeUseCase: GetSavedMemeUseCase
  public var handler: Handler = .none
  
  // MARK: - Initializers
  
  public init(
    router: MyPageRouting,
    userDetail: UserDetail,
    getUserDetailUseCase: GetUserDetailUseCase,
    getLastSeenMemeUseCase: GetLastSeenMemeUseCase,
    getSavedMemeUseCase: GetSavedMemeUseCase
  ) {
    self.router = router
    self.state = State(userDetail: userDetail, lastSeenMemeList: [], savedMemeList: [])
    self.userDetail = userDetail
    self.getUserDetailUseCase = getUserDetailUseCase
    self.getLastSeenMemeUseCase = getLastSeenMemeUseCase
    self.getSavedMemeUseCase = getSavedMemeUseCase
    
    self.initHandler()
    self.fetchUserMemes() // 이걸 routing 에서 하는걸로?
  }
  
  // MARK: - Methods
  @MainActor
  public func dispatch(type: Action) {
    
  }
  
  private func fetchUserMemes() {
    Task {
      do {
        let lastSeenMemeList = try await self.getLastSeenMemeUseCase.execute()
        let savedMemeList = try await self.getSavedMemeUseCase.execute()
        self.state = State(userDetail: state.userDetail,
                           lastSeenMemeList: lastSeenMemeList,
                           savedMemeList: savedMemeList)
      } catch(let error) {
        print("fetchUserMemes error = \(error)")
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
      }
    }
    
    self.handler = Handler(memeClickHandler: memeClickHandler, memeCopyHandler: memeCopyHandler)
  }
}
