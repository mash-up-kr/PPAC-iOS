//
//  GetSavedMemeUseCase.swift
//  PPACDomain
//
//  Created by 장혜령 on 2024/07/15.
//

import Foundation
import PPACModels

public protocol GetSavedMemeUseCase {
  func execute(page: Int, size: Int) async throws -> MemeListWithPagination
}

public class GetSavedMemeUseCaseImpl: GetSavedMemeUseCase {
  public let userRepository: UserRepository
  
  public init(userRepository: UserRepository) {
    self.userRepository = userRepository
  }
  
  public func execute(page: Int, size: Int) async throws -> MemeListWithPagination {
    return try await self.userRepository.getSavedMeme(page: page, size: size)
  }
}
