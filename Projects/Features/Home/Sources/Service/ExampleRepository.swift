//
//  ExampleRepository.swift
//  Home
//
//  Created by 장혜령 on 6/9/24.
//

import Foundation
import PPACModels

protocol ExampleRepository {
  func getExample() -> ExampleVO
}

class ExampleRepositoryImpl: ExampleRepository {
  
  let apiClient: ExampleServiceable
  
  init(apiClient: ExampleServiceable) {
    self.apiClient = apiClient
  }
  
  func getExample() -> ExampleVO {
    Task {
      let exampleDTO = await apiClient.fetchExample()
      let exampleVO = ExampleVO(exampleString: "")
      return exampleVO
    }
  }
}
