//
//  MemeReactionRequestDTO.swift
//  PPACData
//
//  Created by kimchansoo on 10/1/24.
//

import Foundation

public struct MemeReactionRequestDTO: Codable {
  public let count: Int
  
  public init(count: Int) {
    self.count = count
  }
}
