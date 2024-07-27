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
  public let keywords: [String]
  
  public init(category: String, keywords: [String]) {
    self.category = category
    self.keywords = keywords
  }
}

