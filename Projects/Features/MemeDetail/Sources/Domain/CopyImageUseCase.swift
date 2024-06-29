//
//  CopyImageUseCase.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import Foundation
import UniformTypeIdentifiers
import UIKit
import Dependencies

public protocol CopyImageUseCase {
  func execute(data: Data)
}

public final class CopyImageUseCaseImpl: CopyImageUseCase {
  
  
  // MARK: - Properties
  
  // MARK: - Initializers
  
  // MARK: - Methods
  
  public func execute(data: Data) {
    let pasteboard = [
      [UTType.png.identifier : data],
    ]
    UIPasteboard.general.setItems(pasteboard)
  }
}
//
//public enum CopyImageUseCaseKey: DependencyKey, TestDependencyKey {
//  public static let liveValue: any CopyImageUseCase = CopyImageUseCaseImpl()
//  public static let testValue: any CopyImageUseCase = CopyImageUseCaseImpl()
//  public static let previewValue: any CopyImageUseCase = CopyImageUseCaseImpl()
//}
