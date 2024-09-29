//
//  MemeEndpoint.swift
//  PPACData
//
//  Created by kimchansoo on 7/6/24.
//

import Foundation

import PPACNetwork
import PPACUtil

public enum MemeEndpoint: Requestable {
  case recommendMeme(size: Int)
  case getSearchKeywordMemeList(page: Int, size: Int, keyword: String)
  case meme(memeId: String)
  case bookmark(memeId: String)
  case deleteBookmark(memeId: String)
  case share(memeId: String)
  case watch(memeId: String, type: String)
  case reaction(memeId: String, count: Int)

  public var httpMethod: PPACNetwork.HTTPMethod {
    switch self {
    case .recommendMeme:
      return .get
    case .getSearchKeywordMemeList:
      return .get
    case .meme:
      return .get
    case .bookmark:
      return .post
    case .deleteBookmark:
      return .delete
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
    case .getSearchKeywordMemeList(_,_,let keyword):
      return "/meme/search/\(keyword)"
    case .meme(let memeId):
      return "/meme/\(memeId)"
    case .bookmark(let memeId):
      return "/meme/\(memeId)/save"
    case .deleteBookmark(let memeId):
      return "/meme/\(memeId)/save"
    case .share(let memeId):
      return "/meme/\(memeId)/share"
    case .watch(let memeId, let type):
      return "/meme/\(memeId)/watch/\(type)"
    case .reaction(let memeId, _):
      return "/meme/\(memeId)/reaction"
    }
  }
  
  public var parameter: PPACNetwork.HTTPRequestParameter? {
    switch self {
    case .recommendMeme(let size):
      return .query(["size": String(size)])
    case .getSearchKeywordMemeList(let page, let size, let keyword):
      let parameters: [String: String] = [
        "page" : "\(page)",
        "size" : "\(size)",
        "keyword" : "\(keyword)"
      ]
      return .query(parameters)
    case .bookmark:
      return nil
    case .deleteBookmark:
      return nil
    case .share:
      return nil
    case .watch:
      return nil
    case .reaction(_, let count):
      return .body(MemeReactionRequestDTO(count: count))
    case .meme(memeId: _):
      return nil
    }
  }
  
}
