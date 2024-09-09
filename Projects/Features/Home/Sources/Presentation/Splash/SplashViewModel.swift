//
//  SplashViewModel.swift
//  Home
//
//  Created by 장혜령 on 2024/07/11.
//

import SwiftUI

import PPACDomain
import PPACModels
import PPACUtil
import PPACAnalytics

@MainActor
public protocol SplashRouting: AnyObject {
  func showMainTabView(userDetail: UserDetail)
}

final class SplashViewModel: ViewModelType, ObservableObject {
  
  public enum Action { }
  
  public struct State {
    var isVisible: Bool
  }
  
  // MARK: - Properties
  weak var router: SplashRouting?
  @Published var state: State
  private let checkUserInfoUseCase: CheckUserInfoUseCase
  
  // MARK: - Initializers
  init(router: SplashRouting? = nil,
       checkUserInfoUseCase: CheckUserInfoUseCase) {
    self.router = router
    self.state = State(isVisible: true)
    self.checkUserInfoUseCase = checkUserInfoUseCase
    self.fetchUserInfo()
  }
  
  // MARK: - Methods
  @MainActor
  public func dispatch(type: Action) { }
  
  private func fetchUserInfo() {
    Task { @MainActor in
      do {
        let userDetail = try await self.checkUserInfoUseCase.execute()
        self.updateMemeLevel(to: userDetail.level)
        self.state = State(isVisible: false)
        PPACAnalytics.shared.setUserID(userDetail.deviceId)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) { [weak self] in
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
