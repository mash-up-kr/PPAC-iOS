//
//  HotKeyword.swift
//  PPACModels
//
//  Created by 리나 on 2024/06/29.
//

import Foundation

public struct HotKeyword: Hashable {
  
  // MARK: - Properties
  
  public let title: String
  public let imageUrlString: String
  
  // MARK: - Initializers
  
  public init(
    title: String,
    imageUrlString: String
  ) {
    self.title = title
    self.imageUrlString = imageUrlString
  }
}

public extension HotKeyword {
  static let mock1 = HotKeyword(
    title: "띠용오오우어어우어엉?",
    imageUrlString: "https://www.blockmedia.co.kr/wp-content/uploads/2024/05/%EB%8F%84%EC%A7%80%EC%BD%94%EC%9D%B8Doge-%EC%B9%B4%EB%B6%80%EC%88%98.png"
  )
  
  static let mock2 = HotKeyword(
    title: "짜란다짜란다",
    imageUrlString: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_xO_sgszdvyVBp8xz4B82kHmyyO0SNZO-4A&s"
  )
  
  static let mock3 = HotKeyword(
    title: "후회",
    imageUrlString: "https://s3.ap-northeast-2.amazonaws.com/univ-careet/FileData/Picture/202310/3e7e0445-3812-4c06-bc75-a1bed40a3332_770x426.png"
  )
  
  static let mock4 = HotKeyword(
    title: "무한도전",
    imageUrlString: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBnKb96Uc-894Fhgt_5xLsCvY0pSkCl0B4TA&s"
  )
}
