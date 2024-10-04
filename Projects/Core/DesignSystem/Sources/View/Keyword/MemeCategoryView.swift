//
//  MemeCategoryView.swift
//  DesignSystem
//
//  Created by 리나 on 2024/06/30.
//

import SwiftUI
import ResourceKit

public struct MemeCategoryView: View {
  public let category: String
  public let keywordTags: [KeywordTag]
  public let onTapHandler: ((String) -> ())?
  
  public init(
    category: String,
    keywordTags: [KeywordTag],
    onTapHandler: ((String) -> ())?
  ) {
    self.category = category
    self.keywordTags = keywordTags
    self.onTapHandler = onTapHandler
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack {
        Text(category)
          .font(Font.Body.Small.semiBold)
          .foregroundColor(Color.Text.tertiary)
        
        Spacer()
      }
      .padding(.top, 4)
      .padding(.bottom, 16)
      .padding(.horizontal, 20)
      
      KeywordsTagView(keywordTags: keywordTags, onTapHandler: onTapHandler)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
  }
}
