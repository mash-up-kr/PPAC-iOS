//
//  ReactToMemeUseCase.swift
//  PPACDomain
//
//  Created by kimchansoo on 7/11/24.
//

import Foundation

import PPACModels

public protocol ReactToMemeUseCase {
  func execute(memeId: String, count: Int) async throws -> Int
}

public class ReactToMemeUseCaseImpl: ReactToMemeUseCase {
  private let repository: MemeRepository
  
  public init(repository: MemeRepository) {
    self.repository = repository
  }
  
  public func execute(memeId: String, count: Int) async throws -> Int {
    return try await repository.reactToMeme(memeId: memeId, count: count)
  }
}
