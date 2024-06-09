//
//  ExampleServiceable.swift
//  Home
//
//  Created by 장혜령 on 6/9/24.
//

import Foundation
import PPACModels

protocol ExampleServiceable {
  func fetchExample() async throws -> ExampleDTO?
  func postExample(id: Int) async throws -> ExampleDTO?
}
