//
//  MemeDetail.swift
//  PPACModels
//
//  Created by kimchansoo on 6/28/24.
//

import Foundation

public struct MemeDetail: Identifiable {
  
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
    id: "1",
    title: "나는 공부를 찢어",
    keywords: ["공부", "학생", "시험기간"],
    imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
    source: "깃허브",
    isTodayMeme: true,
    reaction: 4
  )
}
