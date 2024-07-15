//
//  CreateUserRequestDTO.swift
//  PPACModels
//
//  Created by 장혜령 on 2024/07/11.
//

import Foundation

public struct CreateUserRequestDTO: Encodable {
  public let deviceId: String
  
  public init(deviceId: String) {
    self.deviceId = deviceId
  }
}
