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
  private let isShortCard: Bool
  
  // MARK: - Initializers
  
  public init(
    keywords: [String],
    isShortCard: Bool
  ) {
    self.keywords = keywords
    self.isShortCard = isShortCard
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
      .foregroundColor(
        isShortCard ? Color.Text.disabled : Color.Text.tertiary
      )
  }
  
}
