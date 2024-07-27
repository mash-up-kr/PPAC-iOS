//
//  SearchKeywordUseCase.swift
//  PPACDomain
//
//  Created by 리나 on 7/18/24.
//

import Foundation

import PPACModels

public protocol SearchKeywordUseCase {
    func execute(keyword: String) async throws -> [MemeDetail]
}

public class SearchKeywordUseCaseImpl: SearchKeywordUseCase {
  private let repository: MemeRepository
  
  public init(repository: MemeRepository) {
    self.repository = repository
  }
  
  public func execute(keyword: String) async throws -> [MemeDetail] {
    try await repository.getSearchKeywordMemeList(keyword: keyword)
  }
}
