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
  case userDetail
  case savedMeme
  case lastSeenMeme
  
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
    return nil
  }
  
  public var path: String? {
    switch self {
    case .create(_):
      return "/user"
    case .userDetail:
      return "/user"
    case .savedMeme:
      return "/user/saved-memes"
    case .lastSeenMeme:
      return "/user/recent-memes"
    }
  }
  
  public var parameter: HTTPRequestParameter? {
    switch self {
    case .create(let deviceId):
      let createDeviceRequest = CreateUserRequestDTO(deviceId: deviceId)
      return .body(createDeviceRequest)
    default:
      return nil
    }
  }
}
