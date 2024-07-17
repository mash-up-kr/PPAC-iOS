//
//  GetRecommendMemesUseCase.swift
//  PPACDomain
//
//  Created by kimchansoo on 7/11/24.
//

import Foundation

import PPACModels
import PPACUtil

public protocol GetRecommendMemesUseCase {
  func execute(size: Int) async throws -> [MemeDetail]
}

public class GetRecommendMemesUseCaseImpl: GetRecommendMemesUseCase {
  private let repository: MemeRepository
  
  public init(repository: MemeRepository) {
    self.repository = repository
  }
  
  public func execute(size: Int) async throws -> [MemeDetail] {
    let deviceId = UserInfo.shared.deviceId
    
    return try await repository.getRecommendMemes(size: size, deviceId: deviceId)
  }
}
