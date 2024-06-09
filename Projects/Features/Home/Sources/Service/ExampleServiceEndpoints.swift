//
//  ExampleServiceEndpoints.swift
//  Home
//
//  Created by 장혜령 on 6/9/24.
//

import Foundation
import PPACNetwork

enum ExampleServiceEndpoints {
  case fetchExample
  case postExmple(id: Int)
  
  var requestTimeOut: Int {
    return 20
  }
  
  var httpMethod: HTTPMethod {
    switch self {
    case .fetchExample:
      return .get
    case .postExmple:
      return .get
    }
  }
  
  var requestBody: [String: String]? {
    switch self {
    case .postExmple(let id):
      return ["id": id]
    default:
      return nil
    }
  }
  
  var url: String {
    let baseUrl = ""
    
    switch self {
    case .fetchExample:
      return "\(baseUrl)/example"
    case .postExmple(let id):
      return "\(baseUrl)/example"
    }
  }
  
  var headers: [String: String] {
    var headers: [String: String] = [:]
    headers["Authorization"] = "token"
    headers["Content-Type"] = "application/json"
    return headers
  }
  
  func createRequest() -> NetworkRequest {
    return NetworkRequest(url: url,
                          httpMethod: httpMethod,
                          headers: headers,
                          body: requestBody)
  }
}

