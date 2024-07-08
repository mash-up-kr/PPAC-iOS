//
//  TopKeywordResponseDTO.swift
//  PPACData
//
//  Created by 장혜령 on 2024/07/07.
//

import Foundation

struct TopKeywordResponseDTO: Decodable {
  let _id: String
  let name: String
  let searchCount: Int?
  let isDeleted: Bool?
  let createdAt: String?
  let updatedAt: String?
  let category: String
  let topReactionImage: String
}
