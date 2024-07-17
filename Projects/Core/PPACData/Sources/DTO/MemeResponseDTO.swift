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
  let keywords: [MemeKeywordResponseDTO]
  let image: String
  let reaction: Int
  let watch: Int
  let source: String
  let isTodayMeme: Bool
  let isDeleted: Bool?
  let createdAt: String
  let updatedAt: String
  let isFarmemed: Bool?
  
  public init(
    _id: String,
    title: String,
    keywords: [MemeKeywordResponseDTO],
    image: String,
    reaction: Int,
    watch: Int,
    source: String,
    isTodayMeme: Bool,
    isDeleted: Bool?,
    createdAt: String,
    updatedAt: String,
    isFarmemed: Bool?
  ) {
    self._id = _id
    self.title = title
    self.keywords = keywords
    self.image = image
    self.reaction = reaction
    self.watch = watch
    self.source = source
    self.isTodayMeme = isTodayMeme
    self.isDeleted = isDeleted
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.isFarmemed = isFarmemed
  }
}

struct MemeKeywordResponseDTO: Decodable {
  let _id: String
  let name: String
  
  public init(
    _id: String,
    name: String
  ) {
    self._id = _id
    self.name = name
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
      isFarmemed: self.isFarmemed ?? false
    )
  }
}
