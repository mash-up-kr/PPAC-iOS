//
//  RecommendKeyword.swift
//  PPACData
//
//  Created by 장혜령 on 2024/07/07.
//

import Foundation

struct RecommendKeywordResponseDTO: Decodable {
  let category: String
  let keywords: [String]
}
