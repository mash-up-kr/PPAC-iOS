//
//  MemeResponseDTO.swift
//  PPACData
//
//  Created by kimchansoo on 7/6/24.
//

import Foundation

import PPACModels

struct MemeWithPaginationResponseDTO: Decodable {
  
  let pagination: Pagination
  let memeList: [MemeResponseDTO]
  
  struct Pagination: Decodable {
    let total: Int
    let page: Int
    let perPage: Int
    let currentPage: Int
    let totalPages: Int
  }
}

struct MemeResponseDTO: Decodable {
  let _id: String
  let title: String
  let keywords: [KeywordResponseDTO]
  let image: String
  let reaction: Int
  let source: String
  let isTodayMeme: Bool
  let isDeleted: Bool?
  let createdAt: String?
  let updatedAt: String
  let isSaved: Bool
  let watch: Int
  
  public init(
    _id: String,
    title: String,
    keywords: [KeywordResponseDTO],
    image: String,
    reaction: Int,
    source: String,
    isTodayMeme: Bool,
    isDeleted: Bool?,
    createdAt: String?,
    updatedAt: String,
    isSaved: Bool,
    watch: Int
  )
  {
    self._id = _id
    self.title = title
    self.keywords = keywords
    self.image = image
    self.reaction = reaction
    self.source = source
    self.isTodayMeme = isTodayMeme
    self.isDeleted = isDeleted
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.isSaved = isSaved
    self.watch = watch
  }
}

extension MemeResponseDTO {
  
  func toModel() -> MemeDetail {
    return MemeDetail(
      id: self._id,
      title: self.title,
      keywords: self.keywords.map { $0.name },
      imageUrlString: self.image,
      source: self.source,
      isTodayMeme: self.isTodayMeme,
      reaction: self.reaction,
      isFarmemed: self.isSaved 
    )
  }
}
