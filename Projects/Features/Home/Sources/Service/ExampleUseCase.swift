//
//  ExampleUseCase.swift
//  Home
//
//  Created by 장혜령 on 6/9/24.
//

import Foundation
import PPACModels

protocol ExampleUseCase {
  func getExample() -> ExampleVO
}

class ExampleUseCaseImpl: ExampleUseCase {
  let repository: ExampleRepository
  
  init(repository: ExampleRepository) {
    self.repository = repository
  }
  
  func getExample() -> ExampleVO {
    return self.repository.getExample()
  }
}
