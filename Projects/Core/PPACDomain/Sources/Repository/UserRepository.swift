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
  func getSavedMeme() async throws -> [MemeDetail]
  func getLastSeenMeme() async throws -> [MemeDetail]
}
