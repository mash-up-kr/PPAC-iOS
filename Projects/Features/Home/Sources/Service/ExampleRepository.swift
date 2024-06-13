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
  func fetchExample() async -> ExampleVO?
  func postExample(id: Int) async -> ExampleVO?
}

class ExampleRepositoryImpl: ExampleRepository {
  
  let apiService: NetworkServiceable
  init(apiService: NetworkServiceable) {
    self.apiService = apiService
  }
  
  func fetchExample() async -> ExampleVO? {
    let request = ExampleServiceEndpoints.getExample
    let (data: ExampleDTO, error) = await self.apiService.request(request)
    guard let data, error == nil else { return nil }
    return ExampleVO(exampleString: response.exampleString ?? "")
  }
  
  func postExample(id: Int) async -> ExampleVO? {
    let request = ExampleServiceEndpoints.postExmple(id: id)
    let (data: ExampleDTO, error) = await self.apiService.request(request)
    guard let data, error == nil else { return nil }
    return ExampleVO(exampleString: response.exampleString ?? "")
  }
}
