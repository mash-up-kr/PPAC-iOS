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
  func execute() async throws -> UserDetail
}

final public class CheckUserInfoUseCaseImpl: CheckUserInfoUseCase {
  public let userRepository: UserRepository
  
  public init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  public func execute() async throws -> UserDetail {
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
    do {
      return try await self.userRepository.getUserDetail()
    } catch(let error) {
      print("getUserDetail error = \(error.localizedDescription)")
      return try await createUser()
    }
  }
}

public class MockCheckUserInfoUseCase: CheckUserInfoUseCase {
  public let userRepository: UserRepository
  
  public init() {
    self.userRepository = MockUserRepository()
  }
  public func execute() async throws -> UserDetail {
    return UserDetail.mock
  }
  
  class MockUserRepository: UserRepository {
    func create(deviceId: String) async throws -> UserDetail { return UserDetail.mock }
    func getUserDetail() async throws -> UserDetail { return UserDetail.mock }
    func getSavedMeme(page: Int, size: Int) async throws -> MemeListWithPagination { return  MemeListWithPagination.mock }
    func getRegisteredMeme(page: Int, size: Int) async throws -> MemeListWithPagination { return  MemeListWithPagination.mock }
    func getLastSeenMeme() async throws -> [MemeDetail] { return [] }
  }
}
