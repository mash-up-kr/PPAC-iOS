//
//  NetworkLogger.swift
//  PPACNetwork
//
//  Created by 장혜령 on 2024/06/14.
//

import Foundation

class NetworkLogger {
    static func logRequest(_ request: URLRequest) {
        print("➡️ [REQUEST]: \(request.httpMethod ?? "N/A") \(request.url?.absoluteString ?? "")")
        if let headers = request.allHTTPHeaderFields {
            print("📝 [HEADERS]: \(headers)")
        }
        if let body = request.httpBody {
            print("📦 [BODY]: \(String(data: body, encoding: .utf8) ?? "N/A")")
        }
    }

    static func logResponse(_ response: URLResponse?, data: Data?) {
        guard let httpResponse = response as? HTTPURLResponse else {
            print("❌ [RESPONSE ERROR]: Invalid response")
            return
        }
        print("⬅️ [RESPONSE]: \(httpResponse.statusCode) \(httpResponse.url?.absoluteString ?? "")")
        if let headers = httpResponse.allHeaderFields as? [String: Any] {
            print("📝 [HEADERS]: \(headers)")
        }
        if let data = data {
            print("📦 [BODY]: \(String(data: data, encoding: .utf8) ?? "N/A")")
        }
    }

    static func logError(_ error: NetworkError) {
        switch error {
        case .urlEncodingError:
            print("❌ [ERROR]: URL Encoding Error")
        case .dataDecodingError:
            print("❌ [ERROR]: Data Decoding Error")
        case .invalidResponse:
            print("❌ [ERROR]: Invalid Response")
        case .clientError(let statusCode, let message):
            print("❌ [CLIENT ERROR]: StatusCode: \(statusCode), Message: \(message ?? "N/A")")
        case .serverError(let statusCode, let message):
            print("❌ [SERVER ERROR]: StatusCode: \(statusCode), Message: \(message ?? "N/A")")
        case .unknown:
            print("❌ [ERROR]: Unknown Error")
        }
    }
}
