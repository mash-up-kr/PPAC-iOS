//
//  Requestable.swift
//  PPACNetwork
//
//  Created by 장혜령 on 6/8/24.
//

import Foundation
import PPACUtil

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
  var httpMethod: HTTPMethod { get }
  var path: String? { get }
  var headers: [String: String]? { get }
  var parameter: HTTPRequestParameter? { get }
  
  func makeURL() -> URL?
  func buildURLRequest(with url: URL) -> URLRequest
}

extension Requestable {
  
  private var baseUrl: String {
    //return "http://ppac-server.run.goorm.io/api/" // 개발 서버
    return "https://ppac-server-goorm.run.goorm.site/api" // 운영 서버
  }
  
  public func makeURL() -> URL? {
    guard let url = URL(string: baseUrl) else { return nil }
    return url.appending(path: path ?? "").append(queries: parameter)
  }
  
  public func buildURLRequest(with url: URL) -> URLRequest {
    var urlRequest = URLRequest(url: url).append(body: parameter)
    urlRequest.httpMethod = httpMethod.rawValue.uppercased()
    
    var defaultHeaders = [
      "x-device-id": UserInfo.shared.testDeviceId,
      "accept": "application/json",
      "Content-Type": "application/json"
    ]
    
    if let additionalHeaders = headers {
      for (key, value) in additionalHeaders {
        defaultHeaders[key] = value
      }
    }
    
    urlRequest.allHTTPHeaderFields = defaultHeaders
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
