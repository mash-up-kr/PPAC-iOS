//
//  ExampleViewModel.swift
//  Home
//
//  Created by 장혜령 on 6/9/24.
//

import Foundation
import SwiftUI

@Observable
class ExampleViewModel {
  let useCase: ExampleUseCase
  
  init(useCase: ExampleUseCase) {
    self.useCase = useCase
  }
  
  func getExample() {
    self.useCase.getExample()
  }
}
