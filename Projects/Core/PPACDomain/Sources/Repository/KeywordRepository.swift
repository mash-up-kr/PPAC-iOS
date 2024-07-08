//
//  KeywordRepository.swift
//  PPACDomain
//
//  Created by 장혜령 on 2024/07/07.
//

import Foundation
import PPACModels

public protocol KeywordRepository {
  func getHotKeywords() async throws -> [HotKeyword]
  func getMimCategorys() async throws -> [MimCategory]
}
