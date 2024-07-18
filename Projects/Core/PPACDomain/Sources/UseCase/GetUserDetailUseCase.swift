//
//  GetUserDetailUseCase.swift
//  PPACDomain
//
//  Created by 장혜령 on 2024/07/15.
//

import Foundation
import PPACModels

public protocol GetUserDetailUseCase {
  func execute() async throws -> UserDetail
}

public class GetUserDetailUseCaseImpl: GetUserDetailUseCase {
  public let userRepository: UserRepository
  
  public init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  public func execute() async throws -> UserDetail {
    return try await self.userRepository.getUserDetail()
  }
}

