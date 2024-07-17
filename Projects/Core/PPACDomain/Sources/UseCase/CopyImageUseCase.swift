//
//  CopyImageUseCase.swift
//  PPACDomain
//
//  Created by 장혜령 on 7/17/24.
//

import UIKit

public protocol CopyImageUseCase {
  func execute(url: String) async throws
}

public class CopyImageUseCaseImpl: CopyImageUseCase {
  
  public init() {}
  
  public func execute(url: String) async throws {
    guard let url = URL(string: url) else {
      return
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      guard let image = UIImage(data: data) else {
        return
      }
      UIPasteboard.general.image = image
      print("이미지 복사 완료")
    } catch {
      print("Failed to load image data: \(error)")
    }
  }
}

