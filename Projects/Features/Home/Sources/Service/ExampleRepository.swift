//
//  ExampleRepository.swift
//  Home
//
//  Created by 장혜령 on 6/9/24.
//

import Foundation
import PPACModels
import PPACNetwork

protocol ExampleRepository {
  func fetchExample() async -> ExampleEntity?
  func postExample(id: Int) async -> ExampleEntity?
}

class ExampleRepositoryImpl: ExampleRepository {
  
  let apiService: NetworkServiceable
  init(apiService: NetworkServiceable) {
    self.apiService = apiService
  }
  
  func fetchExample() async -> ExampleEntity? {
    let request = ExampleServiceEndpoints.fetchExample
      let result = await self.apiService.request(request, dataType: ExampleResponseModel.self)
    switch result {
    case .success(let data):
      return ExampleEntity(exampleString: data.exampleString)
    case .failure(let error):
        return nil
    }
  }
  
  func postExample(id: Int) async -> ExampleEntity? {
    let request = ExampleServiceEndpoints.postExmple(id: id)
      let result = await self.apiService.request(request, dataType: ExampleResponseModel.self)
    switch result {
    case .success(let data):
      return ExampleEntity(exampleString: data.exampleString)
    case .failure(let error):
        return nil
    }
    return ExampleEntity(exampleString: "")
  }
}
