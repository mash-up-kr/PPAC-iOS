//
//  ExampleServiceEndpoints.swift
//  Home
//
//  Created by 장혜령 on 6/9/24.
//

import Foundation
import PPACNetwork

// 각각의 endPoint가 Requestable를 받게하는게 좋을지
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


// 아니면 대부분 들어가는 값들이 비슷하니까 Endpoint를 request 객체로 만드는게 좋을지

