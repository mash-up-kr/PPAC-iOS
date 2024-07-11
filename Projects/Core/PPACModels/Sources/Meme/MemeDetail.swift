//
//  MemeDetail.swift
//  PPACModels
//
//  Created by kimchansoo on 6/28/24.
//

import Foundation

public struct MemeDetail: Identifiable, Hashable {
  
  // MARK: - Properties
  public let id: String
  public let title: String
  public let keywords: [String]
  public let imageUrlString: String
  public let source: String
  public let isTodayMeme: Bool
  public let reaction: Int
  
  // MARK: - Initializers
  
  public init(
    id: String,
    title: String,
    keywords: [String],
    imageUrlString: String,
    source: String,
    isTodayMeme: Bool,
    reaction: Int
  ) {
    self.id = id
    self.title = title
    self.keywords = keywords
    self.imageUrlString = imageUrlString
    self.source = source
    self.isTodayMeme = isTodayMeme
    self.reaction = reaction
  }
}

public extension MemeDetail {
  static let mock = MemeDetail(
    id: "66800ac624fc9c25eaf3b937",
    title: "나는 공부를 찢어",
    keywords: ["공부", "학생", "시험기간"],
    imageUrlString: "https://ppac-meme.s3.ap-northeast-2.amazonaws.com/1.JPG",
    source: "깃허브",
    isTodayMeme: true,
    reaction: 4
  )
}
