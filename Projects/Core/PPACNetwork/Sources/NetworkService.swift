//
//  NetworkService.swift
//  PPACNetwork
//
//  Created by 장혜령 on 6/8/24.
//

import Foundation

final class NetworkService: NetworkServiceable {
  
  func request<T: Decodable>(_ request: Requestable) async -> (data: T?, error: Error?) {
    guard let encodedUrl = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let url = URL(string: encodedUrl) else {
      return (nil, NetworkError.urlEncodingError)
    }
    
    let urlRequest = request.buildURLRequest(with: url)
    
    let (data, response): (Data, URLResponse)
    do {
      (data, response) = try await URLSession.shared.data(for: urlRequest)
    } catch {
      return (nil, NetworkError.invalidResponse)
    }
    
    guard let httpResponse = response as? HTTPURLResponse else {
      return (nil, NetworkError.invalidResponse)
    }
    
    switch httpResponse.statusCode {
    case 200..<300:
      let decoder = JSONDecoder()
      let decodedData = try? decoder.decode(T.self, from: data)
      return (decodedData, nil)
    case 400..<500:
      return (nil, NetworkError.clientError(statusCode: httpResponse.statusCode, message: String(data: data, encoding: .utf8)))
    case 500..<600:
      return (nil, NetworkError.serverError(statusCode: httpResponse.statusCode, message: String(data: data, encoding: .utf8)))
    default:
      return (nil, NetworkError.unknown)
    }
  }
}
