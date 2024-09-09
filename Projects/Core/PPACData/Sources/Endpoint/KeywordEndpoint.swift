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
 
  var httpMethod: HTTPMethod {
    switch self {
    case .getTopKeywords, .getRecommendKeywords:
      return .get
    }
  }
  
  var path: String? {
    switch self {
    case .getTopKeywords:
      return "/keyword/top"
    case .getRecommendKeywords:
      return "/keyword/recommend"
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
  
  var parameter: HTTPRequestParameter? {
    return nil
  }
  
}
