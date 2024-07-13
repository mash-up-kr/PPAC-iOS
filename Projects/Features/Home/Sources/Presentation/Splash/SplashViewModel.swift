//
//  SplashViewModel.swift
//  Home
//
//  Created by 장혜령 on 2024/07/11.
//

import Foundation
import SwiftUI
import PPACDomain
import PPACUtil
import PPACModels

@MainActor
public protocol SplashRouting: AnyObject {
  func popView()
  func showMainTabView(userDetail: UserDetail)
}

final class SplashViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case startSplash
    case finishSplash
  }
  
  public struct State {
    var isVisible: Bool
  }
  
  // MARK: - Properties
  weak var router: SplashRouting?
  @Published var state: State
  @Published var isVisible: Bool = true
  private let checkUserUseCase: CheckUserUseCase
  
  // MARK: - Initializers
  init(router: SplashRouting? = nil,
       checkUserUseCase: CheckUserUseCase) {
    self.router = router
    self.state = State(isVisible: true)
    self.checkUserUseCase = checkUserUseCase
  }
  
  // MARK: - Methods
  @MainActor
  public func dispatch(type: Action) {
    switch type {
    case .startSplash:
      self.fetchUserInfo()
    case .finishSplash:
      //router?.showMainTabView() // 이걸 할 때 navigation에 root를 mainTab으로 해야되지 않을까?
    }
  }
  
  
  private func fetchUserInfo() {
    Task {
      do {
        let userDetail = try await self.checkUserUseCase.checkUserDetail()
        self.updateMemeLevel(to: userDetail.level)
        self.isVisible = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
          self?.router?.popView()
          self?.router?.showMainTabView(userDetail: userDetail)
        }
      } catch(let error) {
        print("fetchUserInfo error = \(error)")
      }
    }
  }
  
  private func updateMemeLevel(to level: Int) {
    UserInfo.shared.memeLevel = level
  }
}
