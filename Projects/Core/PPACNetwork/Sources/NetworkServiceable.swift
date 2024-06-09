//
//  NetworkServiceable.swift
//  PPACNetwork
//
//  Created by 장혜령 on 6/8/24.
//

import Foundation

public protocol NetworkServiceable {
  func request<T: Decodable>(_ request: Requestable) async throws -> T?
}
