//
//  KeywordTag.swift
//  DesignSystem
//
//  Created by 장혜령 on 9/24/24.
//

import Foundation

public struct KeywordTag: Hashable, Identifiable {
  public let id: String
  public let name: String
  public let isSelected: Bool
  
  public init(id: String, name: String, isSelected: Bool = false) {
    self.id = id
    self.name = name
    self.isSelected = isSelected
  }
}
