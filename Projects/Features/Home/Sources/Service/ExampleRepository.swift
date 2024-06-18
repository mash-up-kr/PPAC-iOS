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
  func fetchExample() async -> Example?
  func postExample(id: Int) async -> Example?
}

class ExampleRepositoryImpl: ExampleRepository {
  
  let networkService: NetworkServiceable
  init(networkService: NetworkServiceable) {
    self.networkService = networkService
  }
  
  func fetchExample() async -> Example? {
    let request = ExampleServiceEndpoints.fetchExample
      let result = await self.networkService.request(request, dataType: ExampleResponseModel.self)
    switch result {
    case .success(let data):
      return Example(exampleString: data.exampleString)
    case .failure(let error):
        return nil
    }
  }
  
  func postExample(id: Int) async -> Example? {
    let request = ExampleServiceEndpoints.postExmple(id: id)
      let result = await self.networkService.request(request, dataType: ExampleResponseModel.self)
    switch result {
    case .success(let data):
      return Example(exampleString: data.exampleString)
    case .failure(let error):
        return nil
    }
    return Example(exampleString: "")
  }
}
