//
//  NetworkService.swift
//  PPACNetwork
//
//  Created by 장혜령 on 6/8/24.
//

import Foundation

final public class NetworkService: NetworkServiceable {
  
  public init() {}
  
  public func request<T: Decodable>(_ request: Requestable, dataType: T.Type) async -> Result<T, NetworkError> {
    guard let url = request.makeURL() else {
      NetworkLogger.logError(.urlEncodingError)
      return .failure(.urlEncodingError)
    }
    
    var urlRequest = request.buildURLRequest(with: url)
    
    if let multipartRequest = request as? MultipartRequestable {
      urlRequest.setValue("gzip, deflate, br", forHTTPHeaderField: "accept-encoding")
      urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")
      urlRequest.setValue(multipartRequest.formData.contentType, forHTTPHeaderField: "Content-Type")
      let multipartData = multipartRequest.formData.finalize()
      return await executeUploadRequest(urlRequest, multipartData, dataType: dataType)
    } else {
      return await executeRequest(urlRequest, dataType: dataType)
    }
  }
  
  private func executeRequest<T: Decodable>(_ urlRequest: URLRequest, dataType: T.Type) async -> Result<T, NetworkError> {
    do {
      NetworkLogger.logRequest(urlRequest)
      let (data, response) = try await URLSession.shared.data(for: urlRequest)
      return handleResponse(response, data: data, dataType: dataType)
    } catch let error {
      NetworkLogger.logError(.invalidResponse, message: "\(error)")
      return .failure(.invalidResponse)
    }
  }
  
  private func executeUploadRequest<T: Decodable>(_ urlRequest: URLRequest, _ bodyData: Data, dataType: T.Type) async -> Result<T, NetworkError> {
    do {
      NetworkLogger.logRequest(urlRequest)
      let (data, response) = try await URLSession.shared.upload(for: urlRequest, from: bodyData)
      return handleResponse(response, data: data, dataType: dataType)
    } catch let error {
      NetworkLogger.logError(.invalidResponse, message: "\(error)")
      return .failure(.invalidResponse)
    }
  }
  
  private func handleResponse<T: Decodable>(_ response: URLResponse, data: Data, dataType: T.Type) -> Result<T, NetworkError> {
    guard let httpResponse = response as? HTTPURLResponse else {
      NetworkLogger.logError(.invalidResponse)
      return .failure(.invalidResponse)
    }
    
    NetworkLogger.logResponse(httpResponse, data: data)
    let error: NetworkError
    switch httpResponse.statusCode {
    case 200..<300:
      let decoder = JSONDecoder()
      do {
        let decodedData = try decoder.decode(T.self, from: data)
        return .success(decodedData)
      } catch {
        debugPrint("Decode fail reason: \(error)")
      }
      error = .dataDecodingError
    case 400..<500:
      error = .clientError(statusCode: httpResponse.statusCode, message: String(data: data, encoding: .utf8))
    case 500..<600:
      error = .serverError(statusCode: httpResponse.statusCode, message: String(data: data, encoding: .utf8))
    default:
      error = .unknown
    }
    NetworkLogger.logError(error)
    return .failure(error)
  }
  
}
