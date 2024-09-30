//
//  RegisterMemeUseCase.swift
//  PPACDomain
//
//  Created by 장혜령 on 9/29/24.
//

import Foundation

import PPACNetwork

public protocol RegisterMemeUseCase {
  func execute(formData: FormData, title: String, source: String, keywordIds: [String]) async throws
}

public class RegisterMemeUseCaseImpl: RegisterMemeUseCase {
  private let repository: MemeRepository
  
  public init(repository: MemeRepository) {
    self.repository = repository
  }
  
  public func execute(formData: FormData, title: String, source: String, keywordIds: [String]) async throws {
    try await repository.registerMeme(
      formData: formData,
      title: title,
      source: source,
      keywordIds: keywordIds)
    
  }
}
