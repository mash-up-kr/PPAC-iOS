//
//  CheckUserUseCase.swift
//  PPACDomain
//
//  Created by 장혜령 on 2024/07/13.
//

import Foundation
import PPACModels
import PPACUtil
import PPACNetwork

public protocol CheckUserInfoUseCase {
  func checkUserInfo() async throws -> UserDetail
}

final public class CheckUserInfoUseCaseImpl: CheckUserInfoUseCase {
  public let userRepository: UserRepository
  
  public init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  public func checkUserInfo() async throws -> UserDetail {
    if UserInfo.shared.deviceId.isEmpty {
      return try await createUser()
    } else {
      return try await getUserDetail()
    }
  }
  
  private func createUser() async throws-> UserDetail {
    let deviceId = UUID().uuidString
    let userDetail = try await self.userRepository.create(deviceId: deviceId)
    if !userDetail.deviceId.isEmpty {
      UserInfo.shared.deviceId = userDetail.deviceId
    }
    return userDetail
  }
  
  private func getUserDetail() async throws -> UserDetail {
    return try await self.userRepository.getUserDetail(deviceId: "")
  }
}

public class MockCheckUserInfoUseCase: CheckUserInfoUseCase {
  public let userRepository: UserRepository
  
  public init() {
    userRepository = MockUserRepository()
  }
  public func checkUserInfo() async throws -> UserDetail {
    return UserDetail.mock
  }
  
  class MockUserRepository: UserRepository {
    func create(deviceId: String) async throws -> UserDetail { return UserDetail.mock }
    func getUserDetail(deviceId: String) async throws -> UserDetail { return UserDetail.mock }
    func getSavedMeme(deviceId: String) async throws -> [MemeDetail] { return [] }
    func getLastSeenMeme(deviceId: String) async throws -> [MemeDetail] { return [] }
  }
}
