//
//  ExampleModel.swift
//  PPACModels
//
//  Created by 장혜령 on 6/9/24.
//

import Foundation

public struct ExampleResponseModel: Decodable {
  public var exampleString: String?
  public var exampleString2: String?
}

public struct ExampleEntity: Decodable {
  public var exampleString: String?
  
  enum CodingKeys: String, CodingKey {
    case exampleString
  }
  public init(exampleString: String? = nil) {
    self.exampleString = exampleString
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    exampleString = try container.decodeIfPresent(String.self, forKey: .exampleString)
  }
}
