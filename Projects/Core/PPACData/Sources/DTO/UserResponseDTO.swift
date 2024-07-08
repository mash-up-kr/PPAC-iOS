//
//  UserResponse.swift
//  PPACData
//
//  Created by 김종윤 on 7/6/24.
//

import Foundation

import PPACModels

struct UserResponseDTO: Decodable {
  let _id: String
  let deviceId: String
  let lastSeenMeme: [String]
  let isDeleted: Bool
  let watch: Int
  let reaction: Int
  let save: Int
  let share: Int
  let memeRecommendWatchCount: Int
  let level: Int
  
  public init(
    _id: String,
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
    self._id = _id
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
}

extension UserResponseDTO {
  
  func toModel() -> UserDetail {
    return UserDetail(
      id: self._id,
      deviceId: self.deviceId,
      lastSeenMeme: self.lastSeenMeme,
      isDeleted: self.isDeleted,
      watch: self.watch,
      reaction: self.reaction,
      save: self.save,
      share: self.share,
      memeRecommendWatchCount: self.memeRecommendWatchCount,
      level: self.level
    )
  }
}
