//
//  KeywordEndpoint.swift
//  PPACData
//
//  Created by 장혜령 on 2024/07/07.
//

import Foundation
import PPACNetwork

enum KeywordEndPoint: Requestable {
  case getTopKeywords
  case getRecommendKeywords
  
  var url: String {
    return "https://ppac-server.run.goorm.io"
  }
  
  var httpMethod: HTTPMethod {
    switch self {
    case .getTopKeywords, .getRecommendKeywords:
      return .get
    }
  }
  
  var path: String? {
    switch self {
    case .getTopKeywords:
      return "/api/keyword/top"
    case .getRecommendKeywords:
      return "/api/keyword/recommend"
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
  
  var parameter: HTTPRequestParameter? {
    return nil
  }
  
}
