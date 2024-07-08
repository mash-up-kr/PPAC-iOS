//
//  MemeResponseDTO.swift
//  PPACData
//
//  Created by kimchansoo on 7/6/24.
//

import Foundation

struct MemeResponseDTO: Decodable {
  
  let id: String
  let title: String
  let keywordIds: [String]
  let image: String
  let reaction: Int
  let source: String
  let isTodayMeme: Bool
  let isDeleted: Bool
  let createdAt: String
  let updatedAt: String
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case title
    case keywordIds
    case image
    case reaction
    case source
    case isTodayMeme
    case isDeleted
    case createdAt
    case updatedAt
  }
  
  public init(
    id: String,
    title: String,
    keywordIds: [String],
    image: String,
    reaction: Int,
    source: String,
    isTodayMeme: Bool,
    isDeleted: Bool,
    createdAt: String,
    updatedAt: String
  ) {
    self.id = id
    self.title = title
    self.keywordIds = keywordIds
    self.image = image
    self.reaction = reaction
    self.source = source
    self.isTodayMeme = isTodayMeme
    self.isDeleted = isDeleted
    self.createdAt = createdAt
    self.updatedAt = updatedAt
  }
}
