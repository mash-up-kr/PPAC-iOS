//
//  APIServiceError.swift
//  PPACNetwork
//
//  Created by 장혜령 on 6/8/24.
//

import Foundation

enum APIServiceError: Error {
  case urlEncodingError
  case clientError(message: String?)
  case serverError
}
