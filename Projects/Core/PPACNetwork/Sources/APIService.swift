//
//  APIService.swift
//  PPACNetwork
//
//  Created by 장혜령 on 6/8/24.
//

import Foundation

final class APIService: NetworkServiceable {
  
  static let shared = APIService()
  
  private init() {}
  
  func request<T: Decodable>(_ request: Requestable) async throws -> T? {
    guard let encodedUrl = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let url = URL(string: encodedUrl) else {
      throw APIServiceError.urlEncodingError
    }
    
    let urlRequest = request.buildURLRequest(with: url)
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200..<500) ~= httpResponse.statusCode else {
      throw APIServiceError.serverError
    }
    
    let decoder = JSONDecoder()
    let decodedData = try decoder.decode(T.self, from: data)
    return decodedData
  }
}
