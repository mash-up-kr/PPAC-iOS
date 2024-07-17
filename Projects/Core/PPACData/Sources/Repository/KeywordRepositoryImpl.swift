//
//  KeywordRepositoryImpl.swift
//  PPACData
//
//  Created by 장혜령 on 2024/07/07.
//

import Foundation

import PPACDomain
import PPACNetwork
import PPACModels

public final class KeywordRepositoryImpl: KeywordRepository {
  // MARK: - Properties
  private let networkService: NetworkServiceable
  
  // MARK: - Initializers
  public init(networkService: NetworkServiceable) {
    self.networkService = networkService
  }
  
  // MARK: - Methods
  
  public func getHotKeywords() async throws -> [HotKeyword] {
    let result = await self.networkService
      .request(KeywordEndPoint.getTopKeywords,
               dataType: BaseDTO<[TopKeywordResponseDTO]>.self)
    switch result {
    case .success(let data):
      guard let hotKeywordData = data.data else { throw NetworkError.dataDecodingError }
      let hotKeywords = hotKeywordData
        .compactMap { HotKeyword(title: $0.name, imageUrlString: $0.topReactionImage) }
      return hotKeywords
    case .failure(let error):
      throw error
    }
  }
  
  public func getMimCategorys()  async throws -> [MimCategory] {
    let result = await self.networkService
      .request(KeywordEndPoint.getRecommendKeywords,
               dataType: BaseDTO<[RecommendKeywordResponseDTO]>.self)
    switch result {
    case .success(let data):
      guard let mimCategoryData = data.data else { throw NetworkError.dataDecodingError }
      let mimCategorys = mimCategoryData
        .compactMap { MimCategory(title: $0.category, categories: $0.keywords.map {$0.name }) }
      return mimCategorys
    case .failure(let error):
      throw error
    }
  }
}
