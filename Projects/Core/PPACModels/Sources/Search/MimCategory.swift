//
//  MimCategory.swift
//  PPACModels
//
//  Created by 리나 on 2024/06/29.
//

import Foundation

public struct MimCategory: Hashable {
  public let title: String
  public let categories: [String]
  
  public init(title: String, categories: [String]) {
    self.title = title
    self.categories = categories
  }
}

public extension MimCategory {
  static let mock1 = MimCategory(
    title: "감정",
    categories: ["행복", "슬픈", "무념무상", "분노", "웃긴", "피곤", "절망", "현타", "당황"]
  )
  static let mock2 = MimCategory(
    title: "상황",
    categories: ["회사", "대학", "공부", "연애", "긁", "다이어트", "주식", "고민", "축하", "칭찬"]
  )
  static let mock3 = MimCategory(
    title: "컨텐츠",
    categories: ["동물", "무한도전", "캐릭터", "짱구", "문상훈", "검정고무신", "그 외"]
  )
}
