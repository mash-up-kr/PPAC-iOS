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
    
    init(exampleString: String?) {
        self.exampleString = exampleString
    }
}
