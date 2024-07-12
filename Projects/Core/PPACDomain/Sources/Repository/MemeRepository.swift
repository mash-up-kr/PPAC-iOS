//
//  MemeRepository.swift
//  PPACDomain
//
//  Created by kimchansoo on 7/6/24.
//

import Foundation

import PPACModels

public protocol MemeRepository {
  
  func getRecommendMemes(size: Int) async throws -> [MemeDetail]
  func getMemeDetail(memeId: String) async throws -> MemeDetail
  func bookmarkMeme(memeId: String, deviceId: String) async throws
  func shareMeme(memeId: String, deviceId: String) async throws
  func watchMeme(memeId: String, type: String, deviceId: String) async throws
  func reactToMeme(memeId: String, deviceId: String) async throws
}
