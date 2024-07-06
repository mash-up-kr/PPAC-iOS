//
//  BaseDTO.swift
//  PPACData
//
//  Created by kimchansoo on 7/6/24.
//

import Foundation

struct BaseDTO<T: Codable>: Codable {
  let status: String
  let code: Int
  let message: String
  let data: T?
  
  enum CodingKeys: String, CodingKey {
    case status
    case code
    case message
    case data
  }
  
  public init(
    status: String,
    code: Int,
    message: String,
    data: Codable?
  ) {
    self.status = status
    self.code = code
    self.message = message
    self.data = data
  }
}
