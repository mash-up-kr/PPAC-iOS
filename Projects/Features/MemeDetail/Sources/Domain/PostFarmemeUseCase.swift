//
//  PostFarmemeUseCase.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import Foundation

import Dependencies

public protocol PostFarmemeUseCase {
  func execute(id: String) async -> Bool
}

public final class PostFarmemeUseCaseImpl: PostFarmemeUseCase {
  
  // MARK: - Properties
  
  // MARK: - Initializers
  
  // MARK: - Methods
  
  public func execute(id: String) async -> Bool {
    return false
  }
}

public final class MockPostFarmemeUseCase: PostFarmemeUseCase {
  public func execute(id: String) async -> Bool {
    return false
  }
}

public enum PostFarmemeUseCaseKey: DependencyKey {
  public static let liveValue: any PostFarmemeUseCase = MockPostFarmemeUseCase()
  public static let testValue: any PostFarmemeUseCase = MockPostFarmemeUseCase()
  public static let previewValue: any PostFarmemeUseCase = MockPostFarmemeUseCase()
}
