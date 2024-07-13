//
//  CheckUserUseCase.swift
//  PPACDomain
//
//  Created by 장혜령 on 2024/07/13.
//

import Foundation
import PPACModels
import PPACUtil

public protocol CheckUserUseCase {
  var userRepository: UserRepository { get }
  func checkUserDetail() async throws -> UserDetail
}

final public class CheckUserUseCaseImpl: CheckUserUseCase {
  public let userRepository: UserRepository
  
  public init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  public func checkUserDetail() async throws -> UserDetail {
    if UserInfo.shared.deviceId.isEmpty {
      return try await createUser()
    } else {
      return try await getUserDetail()
    }
  }
  
  private func createUser() async throws-> UserDetail {
    let deviceId = UUID().uuidString
    let userDetail = try await self.userRepository.create(deviceId: deviceId)
    if userDetail.deviceId == deviceId {
      UserInfo.shared.deviceId = deviceId
    }
    return userDetail
  }
  
  private func getUserDetail() async throws -> UserDetail {
    return try await self.userRepository.getUserDetail(deviceId: "")
  }
}
