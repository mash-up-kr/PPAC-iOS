//
//  CreateUserUseCase.swift
//  Home
//
//  Created by 장혜령 on 2024/07/11.
//

import Foundation
import PPACDomain
import PPACModels
import PPACData
import PPACNetwork

final class CreateUserUseCaseImpl: CreateUserUseCase {
  // MARK: - Properties
  var userRepository: UserRepository
  
  // MARK: - Initializers
  init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  // MARK: - Methods
  func excute(id: String) async throws -> UserDetail {
    return try await self.userRepository.create(deviceId: id)
  }
}

public final class MockCreateUserUseCase: CreateUserUseCase {
  public var userRepository: UserRepository
  init() {
    self.userRepository = UserRepositoryImpl(networkservice: NetworkService())
  }
  
  public func excute(id: String) async throws -> UserDetail {
    return UserDetail.mock
  }
}

