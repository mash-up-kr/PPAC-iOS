//
//  UserRepository.swift
//  PPACDomain
//
//  Created by 김종윤 on 7/6/24.
//

import Foundation

import PPACModels

public protocol UserRepository {
  func create(deviceId: String) async throws -> UserDetail
  func getUserDetail() async throws -> UserDetail
  func getLastSeenMeme() async throws -> [MemeDetail]
  func getSavedMeme(page: Int, size: Int) async throws -> MemeListWithPagination
  func getRegisteredMeme(page: Int, size: Int) async throws -> MemeListWithPagination
}
