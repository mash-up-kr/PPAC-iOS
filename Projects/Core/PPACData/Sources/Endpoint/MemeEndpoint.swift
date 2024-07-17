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
  
  case recommendMeme(size: Int)
  case meme(memeId: String)
  case bookmark(memeId: String)
  case share(memeId: String)
  case watch(memeId: String, type: String)
  case reaction(memeId: String)
  
  public var url: String {
    return "https://ppac-server.run.goorm.io/api"
  }
  
  public var httpMethod: PPACNetwork.HTTPMethod {
    switch self {
    case .recommendMeme:
      return .get
    case .meme:
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
    return nil
  }
  
  public var path: String? {
    switch self {
    case .recommendMeme:
      return "/meme/recommend-memes"
    case .meme(let memeId):
      return "/meme/\(memeId)"
    case .bookmark(let memeId):
      return "/meme/\(memeId)/save"
    case .share(let memeId):
      return "/meme/\(memeId)/share"
    case .watch(let memeId, let type):
      return "/meme/\(memeId)/watch/\(type)"
    case .reaction(let memeId):
      return "/meme/\(memeId)/reaction"
    }
  }
  
  public var parameter: PPACNetwork.HTTPRequestParameter? {
    switch self {
    case .recommendMeme(let size):
      return .query(["size": String(size)])
    case .bookmark:
      return nil
    case .share:
      return nil
    case .watch:
      return nil
    case .reaction:
      return nil
    case .meme(memeId: _):
      return nil
    }
  }
  
}
