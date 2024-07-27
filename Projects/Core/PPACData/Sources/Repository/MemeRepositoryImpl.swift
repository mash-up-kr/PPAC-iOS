//
//  MemeRepositoryImpl.swift
//  PPACData
//
//  Created by kimchansoo on 7/6/24.
//

import Foundation
import PPACDomain
import PPACNetwork
import PPACModels

public class MemeRepositoryImpl: MemeRepository {  
  
  // MARK: - Properties
  
  private let networkservice: NetworkServiceable
  
  // MARK: - Initializers
  
  public init(networkservice: NetworkServiceable) {
    self.networkservice = networkservice
  }
  
  // MARK: - Methods
  
  public func getRecommendMemes(size: Int) async throws -> [MemeDetail] {
    let endpoint = MemeEndpoint.recommendMeme(size: size)
    let result = await networkservice.request(endpoint, dataType: BaseDTO<[MemeResponseDTO]>.self)
    switch result {
    case .success(let data):
      guard let dto = data.data else {
        throw NetworkError.dataDecodingError
      }
      return dto.map { $0.toModel() }
    case .failure(let failure):
      throw failure
    }
  }
  
  public func getSearchKeywordMemeList(keyword: String) async throws -> [MemeDetail] {
    let endpoint = MemeEndpoint.getSearchKeywordMemeList(keyword: keyword)
    let result = await networkservice.request(endpoint, dataType: BaseDTO<MemeWithPaginationResponseDTO>.self)
    switch result {
    case .success(let data):
      guard let memeResponseDTOList = data.data?.memeList else { throw NetworkError.dataDecodingError }
      return memeResponseDTOList.map { $0.toModel() }
    case .failure(let error):
      throw error
    }
  }
  
  public func getMemeDetail(memeId: String) async throws -> MemeDetail {
    let endpoint = MemeEndpoint.meme(memeId: memeId)
    let result = await networkservice.request(endpoint, dataType: BaseDTO<MemeResponseDTO>.self)
    switch result {
    case .success(let data):
      guard let data = data.data else {
        throw NetworkError.dataDecodingError
      }
      return data.toModel()
    case .failure(let failure):
      throw failure
    }
  }
  
  public func bookmarkMeme(memeId: String) async throws {
    let endpoint = MemeEndpoint.bookmark(memeId: memeId)
    let result = await networkservice.request(endpoint, dataType: BaseDTO<VoidResponse>.self)
    switch result {
    case .success:
      return
    case .failure(let failure):
      throw failure
    }
  }
  
  public func deleteBookmarkMeme(memeId: String) async throws {
    let endpoint = MemeEndpoint.deleteBookmark(memeId: memeId)
    let result = await networkservice.request(endpoint, dataType: BaseDTO<VoidResponse>.self)
    
    switch result {
    case .success:
      return
    case .failure(let failure):
      throw failure
    }
  }
  
  public func shareMeme(memeId: String) async throws {
    let endpoint = MemeEndpoint.share(memeId: memeId)
    let result = await networkservice.request(endpoint, dataType: BaseDTO<VoidResponse>.self)
    switch result {
    case .success:
      return
    case .failure(let failure):
      throw failure
    }
  }
  
  public func watchMeme(memeId: String, type: String) async throws {
    let endpoint = MemeEndpoint.watch(memeId: memeId, type: type)
    let result = await networkservice.request(endpoint, dataType: BaseDTO<VoidResponse>.self)
    switch result {
    case .success:
      return
    case .failure(let failure):
      throw failure
    }
  }
  
  public func reactToMeme(memeId: String) async throws {
    let endpoint = MemeEndpoint.reaction(memeId: memeId)
    let result = await networkservice.request(endpoint, dataType: BaseDTO<VoidResponse>.self)
    switch result {
    case .success:
      return
    case .failure(let failure):
      throw failure
    }
  }
}

