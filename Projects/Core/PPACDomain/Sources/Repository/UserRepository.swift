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
  func getUserDetail(deviceId: String) async throws -> UserDetail
  func getSavedMeme(deviceId: String) async throws -> [MemeDetail]
  func getLastSeenMeme(deviceId: String) async throws -> [MemeDetail]
}
