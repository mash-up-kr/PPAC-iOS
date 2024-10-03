//
//  GetRegisteredMemeUseCase.swift
//  PPACDomain
//
//  Created by 장혜령 on 10/2/24.
//

import Foundation
import PPACModels

public protocol GetRegisteredMemeUseCase {
  func execute(page: Int, size: Int) async throws -> MemeListWithPagination
}

public class GetRegisteredMemeUseCaseImpl: GetRegisteredMemeUseCase {
  public let userRepository: UserRepository
  
  public init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  public func execute(page: Int, size: Int) async throws -> MemeListWithPagination {
    return try await self.userRepository.getRegisteredMeme(page: page, size: size)
  }
}

