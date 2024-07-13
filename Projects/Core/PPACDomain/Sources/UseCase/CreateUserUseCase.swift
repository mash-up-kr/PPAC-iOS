//
//  CreateUserUseCase.swift
//  PPACDomain
//
//  Created by 장혜령 on 2024/07/11.
//

import Foundation
import PPACModels

public protocol CreateUserUseCase {
  var userRepository: UserRepository { get }
  func excute(id: String) async throws -> UserDetail
}
