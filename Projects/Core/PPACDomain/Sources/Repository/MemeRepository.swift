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
  func getSearchKeywordMemeList(keyword: String) async throws -> [MemeDetail]
  func getMemeDetail(memeId: String) async throws -> MemeDetail
  func bookmarkMeme(memeId: String) async throws
  func shareMeme(memeId: String) async throws
  func watchMeme(memeId: String, type: String) async throws
  func reactToMeme(memeId: String) async throws
}
