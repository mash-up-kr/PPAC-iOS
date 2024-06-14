//
//  ExampleModel.swift
//  PPACModels
//
//  Created by 장혜령 on 6/9/24.
//

import Foundation

struct ExampleResponseModel: Decodable {
  let exampleString: String?
  let exampleString2: String?
}

struct ExampleEntity: Decodable {
  let exampleString: String?
}
