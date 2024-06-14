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
    let request = ExampleServiceEndpoints.getExample
    let (data: ExampleResponseModel, error) = await self.apiService.request(request)
    guard let data, error == nil else { return nil }
    return ExampleEntity(exampleString: data.exampleString ?? "")
  }
  
  func postExample(id: Int) async -> ExampleEntity? {
    let request = ExampleServiceEndpoints.postExmple(id: id)
    let (data: ExampleResponseModel, error) = await self.apiService.request(request)
    guard let data, error == nil else { return nil }
    return ExampleEntity(exampleString: data.exampleString ?? "")
  }
}
