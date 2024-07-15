//
//  UserRepositoryImpl.swift
//  PPACData
//
//  Created by 김종윤 on 7/7/24.
//

import Foundation

import PPACDomain
import PPACModels
import PPACNetwork

public final class UserRepositoryImpl: UserRepository {
  
  // MARK: - Properties
  private let networkservice: NetworkServiceable
  
  // MARK: - Initializers
  
  public init(networkservice: NetworkServiceable) {
    self.networkservice = networkservice
  }
  
  // MARK: - Methods
  public func create(deviceId: String) async throws -> UserDetail {
    let result = await networkservice
      .request(
        UserEndpoint.create(deviceId: deviceId),
        dataType: BaseDTO<UserResponseDTO>.self
      )
    
    switch result {
    case .success(let data):
      guard let UserResponseDTO = data.data else { throw NetworkError.dataDecodingError }
      return UserResponseDTO.toModel()
    case .failure(let error):
      throw error
    }
  }
  
  public func getUserDetail() async throws -> UserDetail {
    let result = await networkservice
      .request(
        UserEndpoint.userDetail,
        dataType: BaseDTO<UserResponseDTO>.self
      )
    switch result {
    case .success(let data):
      guard let userResponseDTO = data.data else { throw NetworkError.dataDecodingError }
      return userResponseDTO.toModel()
    case .failure(let error):
      throw error
    }
  }
  
  public func getSavedMeme() async throws -> [MemeDetail] {
    let result = await networkservice
      .request(
        UserEndpoint.savedMeme,
        dataType: BaseDTO<MemeWithPaginationResponseDTO>.self
      )
    
    switch result {
    case .success(let data):
      guard let memeResponseDTOList = data.data?.memeList else { throw NetworkError.dataDecodingError }
      return memeResponseDTOList.map { $0.toModel() }
    case .failure(let error):
      throw error
    }
  }
  
  public func getLastSeenMeme() async throws -> [MemeDetail] {
    let result = await networkservice
      .request(
        UserEndpoint.lastSeenMeme,
        dataType: BaseDTO<[MemeResponseDTO]>.self
      )
    
    switch result {
    case .success(let data):
      guard let memeResponseDTOList = data.data else { throw NetworkError.dataDecodingError }
      return memeResponseDTOList.map { $0.toModel() }
    case .failure(let error):
      throw error
    }
  }
}
