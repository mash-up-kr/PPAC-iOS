//
//  NetworkRequest.swift
//  PPACNetwork
//
//  Created by 장혜령 on 6/8/24.
//

import Foundation

public struct NetworkRequest: Requestable {
  public var url: String
  public var httpMethod: HTTPMethod
  public var headers: [String: String]?
  public var body: Data?
  
  init(url: String,
       httpMethod: HTTPMethod,
       headers: [String: String]? = nil,
       body: [String: Any]? = nil) {
    self.url = url
    self.httpMethod = httpMethod
    self.headers = headers
    self.body = body?.toJsonString()?.data(using: .utf8)
  }
  
  public func buildURLRequest(with url: URL) -> URLRequest {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = httpMethod.rawValue.uppercased()
    urlRequest.allHTTPHeaderFields = headers ?? [:]
    urlRequest.httpBody = body
    return urlRequest
  }
}
