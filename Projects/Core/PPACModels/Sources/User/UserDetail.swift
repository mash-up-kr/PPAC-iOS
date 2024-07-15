//
//  UserDetail.swift
//  PPACModels
//
//  Created by 김종윤 on 7/6/24.
//

import Foundation

public struct UserDetail {
  public let id: String
  public let deviceId: String
  public let lastSeenMeme: [String]
  public let isDeleted: Bool
  public let watch: Int
  public let reaction: Int
  public let save: Int
  public let share: Int
  public let memeRecommendWatchCount: Int
  public let level: Int
  
  public init(
    id: String,
    deviceId: String,
    lastSeenMeme: [String],
    isDeleted: Bool,
    watch: Int,
    reaction: Int,
    save: Int,
    share: Int,
    memeRecommendWatchCount: Int,
    level: Int
  ) {
    self.id = id
    self.deviceId = deviceId
    self.lastSeenMeme = lastSeenMeme
    self.isDeleted = isDeleted
    self.watch = watch
    self.reaction = reaction
    self.save = save
    self.share = share
    self.memeRecommendWatchCount = memeRecommendWatchCount
    self.level = level
  }
  
  public static let mock = UserDetail(
      id: "668fab1720cb620e974c53b3",
      deviceId: "1111-2222-3333-4444",
      lastSeenMeme: [],
      isDeleted: false,
      watch: 0,
      reaction: 0,
      save: 0,
      share: 0,
      memeRecommendWatchCount: 0,
      level: 1
  )
}
