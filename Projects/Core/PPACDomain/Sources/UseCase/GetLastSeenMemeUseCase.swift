//
//  GetLastSeenMemeUseCase.swift
//  PPACDomain
//
//  Created by 장혜령 on 2024/07/15.
//

import Foundation
import PPACModels

public protocol GetLastSeenMemeUseCase {
  func execute() async throws -> [MemeDetail]
}

public class GetLastSeenMemeUseCaseImpl: GetLastSeenMemeUseCase {
  public let userRepository: UserRepository
  
  public init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  public func execute() async throws -> [MemeDetail] {
    return try await self.userRepository.getLastSeenMeme()
  }
  
}
