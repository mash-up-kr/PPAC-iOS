//
//  NetworkService.swift
//  PPACNetwork
//
//  Created by 장혜령 on 6/8/24.
//

import Foundation

final class NetworkService: NetworkServiceable {
  
    func request<T: Decodable>(_ request: Requestable, dataType: T.Type) async -> Result<T, NetworkError> {
    guard let encodedUrl = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let url = URL(string: encodedUrl) else {
        return .failure(.urlEncodingError)
    }
    
    let urlRequest = request.buildURLRequest(with: url)
    
    
    let (data, response): (Data, URLResponse)
    do {
      (data, response) = try await URLSession.shared.data(for: urlRequest)
    } catch {
        NetworkLogger.logError(.invalidResponse)
        return .failure(.invalidResponse)
    }
    
    guard let httpResponse = response as? HTTPURLResponse else {
      NetworkLogger.logError(.invalidResponse)
      return .failure(.invalidResponse)
    }
    
    let error: NetworkError
    switch httpResponse.statusCode {
    case 200..<300:
      let decoder = JSONDecoder()
        if let decodedData = try? decoder.decode(T.self, from: data) {
            return .success(decodedData)
        } else {
            error = .dataDecodingError
        }
    case 400..<500:
        error = .clientError(statusCode: httpResponse.statusCode, message: String(data: data, encoding: .utf8))
    case 500..<600:
        error = .serverError(statusCode: httpResponse.statusCode, message: String(data: data, encoding: .utf8))
    default:
        error = .unknown
    }
    return .failure(error)
  }
}
