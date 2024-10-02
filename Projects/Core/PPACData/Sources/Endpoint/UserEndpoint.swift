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
  case lastSeenMeme
  case savedMeme(page: Int, size: Int)
  case registeredMemes(page: Int, size: Int)
  
  
  public var httpMethod: PPACNetwork.HTTPMethod {
    switch self {
    case .create:
      return .post
    case .userDetail,
        .lastSeenMeme,
        .savedMeme,
        .registeredMemes:
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
    case .lastSeenMeme:
      return "/user/recent-memes"
    case .savedMeme:
      return "/user/saved-memes"
    case .registeredMemes:
      return "/user/registered-memes"
    }
  }
  
  public var parameter: HTTPRequestParameter? {
    switch self {
    case .create(let deviceId):
      let createDeviceRequest = CreateUserRequestDTO(deviceId: deviceId)
      return .body(createDeviceRequest)
    case .savedMeme(let page, let size):
      let parameters: [String: String] = [
        "page" : "\(page)",
        "size" : "\(size)"
      ]
      return .query(parameters)
    case .registeredMemes(let page, let size):
      let parameters: [String: String] = [
        "page" : "\(page)",
        "size" : "\(size)"
      ]
      return .query(parameters)
    default:
      return nil
    }
  }
}
