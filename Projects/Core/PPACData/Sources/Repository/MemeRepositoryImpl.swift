//
//  MemeRepositoryImpl.swift
//  PPACData
//
//  Created by kimchansoo on 7/6/24.
//

import Foundation

import PPACDomain
import PPACNetwork
import PPACModels

public final class MemeRepositoryImpl: MemeRepository {
  
  // MARK: - Properties
  
  private let networkservice: NetworkServiceable
  
  // MARK: - Initializers
  
  public init(networkservice: NetworkServiceable) {
    self.networkservice = networkservice
  }
  
  // MARK: - Methods
  
  public func getTodayMemes() -> [MemeDetail] {
    return []
  }
}
