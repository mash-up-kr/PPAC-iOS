//
//  MemeReactionRequestDTO.swift
//  PPACData
//
//  Created by 김종윤 on 9/28/24.
//

import Foundation

struct MemeReactionRequestDTO: Encodable {
  public let count: Int
  
  public init(count: Int) {
    self.count = count
  }
}
