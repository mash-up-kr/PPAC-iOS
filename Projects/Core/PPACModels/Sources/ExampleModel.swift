//
//  ExampleModel.swift
//  PPACModels
//
//  Created by 장혜령 on 6/9/24.
//

import Foundation

struct ExampleDTO: Decodable {
  let exampleString: String?
  let exampleString2: String?
}

struct ExampleVO: Decodable {
  let exampleString: String?
}
