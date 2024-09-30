//
//  MemeCategory.swift
//  PPACModels
//
//  Created by 리나 on 2024/06/29.
//

import Foundation

public struct MemeCategory: Hashable, Identifiable {
  public let id = UUID()
  public let category: String
  public var keywords: [MemeKeyword]
  
  public init(category: String, keywords: [MemeKeyword]) {
    self.category = category
    self.keywords = keywords
  }
}

public struct MemeKeyword: Hashable, Identifiable {
  public let id: String
  public let name: String
  public var isSelected: Bool
  
  public init(id: String, name: String, isSelected: Bool = false) {
    self.id = id
    self.name = name
    self.isSelected = isSelected
  }
}
