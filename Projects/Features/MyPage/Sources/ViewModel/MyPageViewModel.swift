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
}

final public class MyPageViewModel: ViewModelType, ObservableObject {
  
  public enum Action { }
  
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
  @Published public var state: State
  private var userDetail: UserDetail
  private let getUserDetailUseCase: GetUserDetailUseCase
  private let getLastSeenMemeUseCase: GetLastSeenMemeUseCase
  private let getSavedMemeUseCase: GetSavedMemeUseCase
  
  // MARK: - Initializers
  
  public init(
    userDetail: UserDetail,
    getUserDetailUseCase: GetUserDetailUseCase,
    getLastSeenMemeUseCase: GetLastSeenMemeUseCase,
    getSavedMemeUseCase: GetSavedMemeUseCase
  ) {
    self.state = State(userDetail: userDetail, lastSeenMemeList: [], savedMemeList: [])
    self.userDetail = userDetail
    self.getUserDetailUseCase = getUserDetailUseCase
    self.getLastSeenMemeUseCase = getLastSeenMemeUseCase
    self.getSavedMemeUseCase = getSavedMemeUseCase
    
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
        print("lastSeenMemeList = \(lastSeenMemeList)")
        print("savedMemeList = \(savedMemeList)")
      } catch(let error) {
        print("fetchUserMemes error = \(error)")
      }
    }
  }
}
