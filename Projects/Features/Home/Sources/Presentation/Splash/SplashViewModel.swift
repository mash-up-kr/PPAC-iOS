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
public protocol SplachRouting: AnyObject {
  func popView()
  func showMainTabView()
}

final class SplashViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case startSplash
    case finishSplash
  }
  
  public struct State {
    public var userDetail: UserDetail?
  }
  
  // MARK: - Properties
  weak var router: SplachRouting?
  @Published public var state: State
  @Published var isVisible: Bool = true
  private let createUserUserCase: CreateUserUseCase
  
  // MARK: - Initializers
  init(router: SplachRouting? = nil,
       createUserUserCase: CreateUserUseCase) {
    self.router = router
    self.state = State(userDetail: nil)
    self.createUserUserCase = createUserUserCase
  }
  
  // MARK: - Methods
  @MainActor
  public func dispatch(type: Action) {
    switch type {
    case .startSplash:
      self.fetchUserInfo()
    case .finishSplash:
      router?.showMainTabView() // 이걸 할 때 navigation에 root를 mainTab으로 해야되지 않을까?
    }
  }
  
  private func fetchUserInfo() {
    Task {
      do {
        let userDetail = try await self.createUserUserCase.excute(id: UserManager.uuid)
        self.updateMemeLevel(to: userDetail.level)
        self.state = State(userDetail: userDetail)
        self.isVisible = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
          self?.router?.popView()
          self?.router?.showMainTabView()
        }
      } catch(let error) {
        print("fetchUserInfo error = \(error)")
      }
    }
  }
  
  private func updateMemeLevel(to level: Int) {
    UserManager.memeLevel = level
  }
}
