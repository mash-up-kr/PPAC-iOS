//
//  GetUserInfoUseCase.swift
//  PPACDomain
//
//  Created by 김종윤 on 7/17/24.
//

import Foundation

import PPACModels
import PPACUtil

public protocol GetUserInfoUseCase {
  func get() async throws -> UserDetail
}

final public class GetUserInfoUseCaseImpl: GetUserInfoUseCase {
  private let userRepository: UserRepository
  
  public init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  public func get() async throws -> UserDetail {
    return try await self.userRepository.getUserDetail()
  }
  
}
