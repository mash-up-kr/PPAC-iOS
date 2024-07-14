//
//  MemeResponseDTO.swift
//  PPACData
//
//  Created by kimchansoo on 7/6/24.
//

import Foundation

import PPACModels

struct MemeResponseDTO: Decodable {
  let _id: String
  let title: String
  let keywordIds: [String]
  let image: String
  let reaction: Int
  let source: String
  let isTodayMeme: Bool
  let isDeleted: Bool
  let createdAt: String
  let updatedAt: String
  let isFarmemed: Bool?
  
  public init(
    _id: String,
    title: String,
    keywordIds: [String],
    image: String,
    reaction: Int,
    source: String,
    isTodayMeme: Bool,
    isDeleted: Bool,
    createdAt: String,
    updatedAt: String,
    isFarmemed: Bool?
  ) {
    self._id = _id
    self.title = title
    self.keywordIds = keywordIds
    self.image = image
    self.reaction = reaction
    self.source = source
    self.isTodayMeme = isTodayMeme
    self.isDeleted = isDeleted
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.isFarmemed = isFarmemed
  }
}

extension MemeResponseDTO {
  
  func toModel() -> MemeDetail {
    return MemeDetail(
      id: self._id,
      title: self.title,
      keywords: self.keywordIds,
      imageUrlString: self.image,
      source: self.source,
      isTodayMeme: self.isTodayMeme,
      reaction: self.reaction,
      isFarmemed: self.isFarmemed ?? false
    )
  }
}
