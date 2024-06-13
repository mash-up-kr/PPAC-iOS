//
//  NetworkError.swift
//  PPACNetwork
//
//  Created by 장혜령 on 6/8/24.
//

import Foundation

enum NetworkError: Error {
  /// encoding Error
  case urlEncodingError
  /// response Error
  case invalidResponse
  /// statucCode 400 ~ 499 error
  case clientError(statusCode: Int, message: String?)
  /// statucCode 500 ~ error
  case serverError(statusCode: Int, message: String?)
  /// 알 수 없는 에러
  case unknown
}
