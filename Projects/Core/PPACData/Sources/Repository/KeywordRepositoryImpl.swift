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
    let endPoint = KeywordEndPoint.getTopKeywords
    let result = await self.networkService.request(endPoint, dataType: BaseDTO<[TopKeywordResponseDTO]>.self)
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
  
  public func getMemeCategorys()  async throws -> [MemeCategory] {
    let endPoint = KeywordEndPoint.getRecommendKeywords
    let result = await self.networkService.request(endPoint, dataType: BaseDTO<[RecommendKeywordResponseDTO]>.self)
    switch result {
    case .success(let data):
      guard let memeCategoryData = data.data else { throw NetworkError.dataDecodingError }
      let memeCategorys = memeCategoryData
        .compactMap {
          MemeCategory(
            category: $0.category,
            keywords: $0.keywords.map { MemeKeyword(id: $0._id, name: $0.name) }
          )
        }
      return memeCategorys
    case .failure(let error):
      throw error
    }
  }
}
