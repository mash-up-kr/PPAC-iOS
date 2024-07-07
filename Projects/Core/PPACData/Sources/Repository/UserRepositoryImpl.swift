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
        dataType: UserResponseDTO.self
      )
    
    switch result {
    case .success(let userResponseDTO):
      return userResponseDTO.toModel()
    case .failure(let error):
      throw error
    }
  }
  
  public func getUserDetail(deviceId: String) async throws -> UserDetail {
    let result = await networkservice
      .request(
        UserEndpoint.userDetail(deviceId: deviceId),
        dataType: UserResponseDTO.self
      )
    
    switch result {
    case .success(let userResponseDTO):
      return userResponseDTO.toModel()
    case .failure(let error):
      throw error
    }
    
  }
  
  public func getSavedMeme(deviceId: String) async throws -> [MemeDetail] {
    let result = await networkservice
      .request(
        UserEndpoint.savedMeme(deviceId: deviceId),
        dataType: [MemeResponseDTO].self
      )
    
    switch result {
    case .success(let memeDetails):
      return memeDetails.map { $0.toModel() }
      
    case .failure(let error):
      throw error
    }
  }
  
  public func getLastSeenMeme(deviceId: String) async throws -> [MemeDetail] {
    let result = await networkservice
      .request(
        UserEndpoint.lastSeenMeme(deviceId: deviceId),
        dataType: [MemeResponseDTO].self
      )
    
    switch result {
    case .success(let memeDetails):
      return memeDetails.map { $0.toModel() }
      
    case .failure(let error):
      throw error
    }
  }
}
