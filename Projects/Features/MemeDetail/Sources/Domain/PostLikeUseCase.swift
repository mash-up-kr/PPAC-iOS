//
//  PostLikeUseCase.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import Foundation

import Dependencies

public protocol PostLikeUseCase {
  
  func execute(id: String) async -> Bool
}

public final class PostLikeUseCaseImpl: PostLikeUseCase {
  
  // MARK: - Properties
  
  // MARK: - Initializers
  
  // MARK: - Methods
  
  public func execute(id: String) async -> Bool {
    // TODO: - api 나오면 연결
    return true
  }
}

public final class MockPostLikeUseCase: PostLikeUseCase {
  public func execute(id: String) async -> Bool {
    return true
  }
}

public enum PostLikeUseCaseKey: DependencyKey {
  public static let liveValue: any PostLikeUseCase = MockPostLikeUseCase()
  public static let testValue: any PostLikeUseCase = MockPostLikeUseCase()
  public static let previewValue: any PostLikeUseCase = MockPostLikeUseCase()
}
