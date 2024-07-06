//
//  MemeRepository.swift
//  PPACDomain
//
//  Created by kimchansoo on 7/6/24.
//

import Foundation

import PPACModels

public protocol MemeRepository {
  func getTodayMemes() -> [MemeDetail]
//  func postWatchMeme()
}
