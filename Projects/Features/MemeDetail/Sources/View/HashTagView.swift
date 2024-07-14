//
//  HashTagView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI

import ResourceKit

public struct HashTagView: View {
  
  // MARK: - Properties
  
  private let keywords: [String]
  
  // MARK: - Initializers
  
  public init(keywords: [String]) {
    self.keywords = keywords
  }
  
  // MARK: - UI
  
  public var body: some View {
    HStack(alignment: .center, spacing: 6) {
      ForEach(keywords, id: \.self) { title in
        hashTag(title: title)
      }
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .cornerRadius(40)
  }
  
  func hashTag(title: String) -> some View {
    Text("#\(title)")
      .font(Font.Body.Large.medium)
      .foregroundColor(Color.Text.tertiary)
  }
  
}
