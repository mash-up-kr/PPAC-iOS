//
//  HashTagView.swift
//  Recommend
//
//  Created by 김종윤 on 7/13/24.
//
import SwiftUI

import ResourceKit

struct HashTagView: View {
  private let keywords: [String]
  
  public init(keywords: [String]) {
    self.keywords = keywords
  }
  
  public var body: some View {
    HStack(alignment: .center, spacing: 4) {
      ForEach(keywords, id: \.self) { title in
        hashTag(title: title)
      }
    }
    .frame(alignment: .center)
  }
  
  func hashTag(title: String) -> some View {
    Text("#\(title)")
      .font(Font.Body.Medium.medium)
      .foregroundColor(Color.Text.secondary)
  }
}
