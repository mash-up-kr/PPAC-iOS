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

public enum HTTPRequestParameter {
  case query([String: String])
  case body(Encodable)
}

public protocol Requestable {
  var url: String { get }
  var httpMethod: HTTPMethod { get }
  var headers: [String: String]? { get }
  var parameter: HTTPRequestParameter? { get }
  
  func makeURL() -> URL?
  func buildURLRequest(with url: URL) -> URLRequest
}

extension Requestable {

  public func makeURL() -> URL? {
    return URL(string: url)?.append(queries: parameter)
  }
  
  public func buildURLRequest(with url: URL) -> URLRequest {
    var urlRequest = URLRequest(url: url)
      .append(body: parameter)
    urlRequest.httpMethod = httpMethod.rawValue.uppercased()
    urlRequest.allHTTPHeaderFields = headers ?? [:]
    return urlRequest
  }
}

extension URLRequest {
  
  func append(body parameter: HTTPRequestParameter?) -> URLRequest {
    var request = self
    
    if case .body(let bodyParamters) = parameter {
      let encodedParameters = try? JSONEncoder().encode(bodyParamters)
      request.httpBody = encodedParameters
    }
    
    return request
  }
  
}

extension URL {
  func append(queries parameter: HTTPRequestParameter?) -> URL? {
    var components = URLComponents(string: self.absoluteString)
    
    if case .query(let queries) = parameter {
      let queryItems = queries.map { URLQueryItem(name: $0, value: $1) }
      components?.queryItems = queryItems
    }
    
    return components?.url
  }
}
