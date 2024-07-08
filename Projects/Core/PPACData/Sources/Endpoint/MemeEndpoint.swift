////
////  MemeEndpoint.swift
////  PPACData
////
////  Created by kimchansoo on 7/6/24.
////
//
//import Foundation
//
//import PPACNetwork
//

import Foundation

import PPACNetwork

public enum MemeEndpoint: Requestable {
  
  case todayMemes
  case meme(memeId: String)
  case bookmark(memeId: String, deviceId: String)
  case share(memeId: String, deviceId: String)
  case watch(memeId: String, type: String, deviceId: String)
  case reaction(memeId: String, deviceId: String)
  
  public var url: String {
    return "https://ppac-server.run.goorm.io/api"
  }
  
  public var httpMethod: PPACNetwork.HTTPMethod {
    switch self {
    case .todayMemes:
      return .get
    case .meme(_):
      return .get
    case .bookmark:
      return .post
    case .share:
      return .post
    case .watch:
      return .post
    case .reaction:
      return .post
    }
  }
  public var headers: [String : String]? {
    switch self {
    case .todayMemes, .meme:
      return nil
    case .bookmark(_, let deviceId):
      return ["deviceId": deviceId]
    case .share(_, let deviceId):
      return ["deviceId": deviceId]
    case .watch(_, _, let deviceId):
      return ["deviceId": deviceId]
    case .reaction(_, let deviceId):
      return ["deviceId": deviceId]
    }
  }
  
  public var path: String? {
    switch self {
    case .todayMemes:
      return "/meme/todayMeme"
    case .meme(let memeId):
      return "/meme/\(memeId)"
    case .bookmark(let memeId, _):
      return "/meme/\(memeId)/save"
    case .share(let memeId, _):
      return "/meme/\(memeId)/share"
    case .watch(let memeId, let type, _):
      return "/meme/\(memeId)/watch/\(type)"
    case .reaction(let memeId, _):
      return "/meme/\(memeId)/reaction"
    }
  }
  
  public var parameter: PPACNetwork.HTTPRequestParameter? {
    switch self {
    case .todayMemes:
      return nil
    case .bookmark(_, _):
      return nil
    case .share(_, _):
      return nil
    case .watch(_, _, _):
      return nil
    case .reaction(_, _):
      return nil
    case .meme(memeId: _):
      return nil
    }
  }
  
}
