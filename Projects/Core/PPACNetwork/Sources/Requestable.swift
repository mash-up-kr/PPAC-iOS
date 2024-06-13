//
//  Requestable.swift
//  PPACNetwork
//
//  Created by 장혜령 on 6/8/24.
//

import Foundation

public enum HTTPMethod: String {
  case get
  case post
  case put
  case delete
}

public protocol Requestable {
  var url: String { get }
  var httpMethod: HTTPMethod { get }
  var headers: [String: String]? { get }
  var body: [String: Any]? { get }
  
  func buildURLRequest(with url: URL) -> URLRequest
}

extension Requestable {
  public func buildURLRequest(with url: URL) -> URLRequest {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = httpMethod.rawValue.uppercased()
    urlRequest.allHTTPHeaderFields = headers ?? [:]
    urlRequest.httpBody = body?.toJsonString()?.data(using: .utf8)
    return urlRequest
  }
}

