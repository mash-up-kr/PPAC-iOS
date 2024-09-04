//
//  SearchKeywordUseCase.swift
//  PPACDomain
//
//  Created by 리나 on 7/18/24.
//

import Foundation

import PPACModels

public protocol SearchKeywordUseCase {
  func execute(page: Int, size: Int, keyword: String) async throws -> MemeListWithPagination
}

public class SearchKeywordUseCaseImpl: SearchKeywordUseCase {
  private let repository: MemeRepository
  
  public init(repository: MemeRepository) {
    self.repository = repository
  }
  
  public func execute(page: Int, size: Int, keyword: String) async throws -> MemeListWithPagination {
    try await repository.getSearchKeywordMemeList(page: page, size: size, keyword: keyword)
  }
}
