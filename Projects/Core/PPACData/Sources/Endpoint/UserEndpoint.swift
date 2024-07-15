//
//  UserEndpoint.swift
//  PPACData
//
//  Created by 김종윤 on 7/7/24.
//

import Foundation
import PPACNetwork
import PPACModels

public enum UserEndpoint: Requestable {
  
  case create(deviceId: String)
  case userDetail(deviceId: String)
  case savedMeme(deviceId: String)
  case lastSeenMeme(deviceId: String)
  
  public var url: String {
    return "https://ppac-server.run.goorm.io/api"
  }
  
  public var httpMethod: PPACNetwork.HTTPMethod {
    switch self {
    case .create:
      return .post
    case .userDetail:
      return .get
    case .savedMeme:
      return .get
    case .lastSeenMeme:
      return .get
    }
  }
  
  public var headers: [String : String]? {
    switch self {
    case .create(let deviceId):
      return ["deviceId": deviceId]
    case .userDetail(let deviceId):
      return ["deviceId": deviceId]
    case .savedMeme(let deviceId):
      return ["deviceId": deviceId]
    case .lastSeenMeme(let deviceId):
      return ["deviceId": deviceId]
    }
  }
  
  public var path: String? {
    switch self {
    case .create(_):
      return "/user"
    case .userDetail(_):
      return "/user"
    case .savedMeme(_):
      return "/user/saved-memes"
    case .lastSeenMeme(_):
      return "/user/recent-memes"
    }
  }
  
  public var parameter: HTTPRequestParameter? {
    switch self {
    case .create(let deviceId):
      let createDeviceRequest = CreateUserRequestDTO(deviceId: deviceId)
      return .body(createDeviceRequest)
    case .userDetail(_):
      return nil
    case .savedMeme(_):
      return nil
    case .lastSeenMeme(_):
      return nil
    }
  }
}
