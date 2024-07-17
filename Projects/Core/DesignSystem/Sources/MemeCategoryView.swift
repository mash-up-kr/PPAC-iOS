//
//  MemeCategoryView.swift
//  DesignSystem
//
//  Created by 리나 on 2024/06/30.
//

import SwiftUI
import ResourceKit
import PPACModels

public struct MemeCategoryView: View {
  public let category: String
  public let keywords: [String]
  public let onClickHandler: ((String) -> ())?
  
  public init(category: String, keywords: [String], onClickHandler: ((String) -> ())?) {
    self.category = category
    self.keywords = keywords
    self.onClickHandler = onClickHandler
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text(category)
          .font(Font.Body.Small.semiBold)
          .foregroundColor(Color.Text.tertiary)
        
        Spacer()
      }
      .padding(.top, 4)
      .padding(.bottom, 16)
      .padding(.horizontal, 20)
      
      KeywordsTagView(keywords: keywords, onClickHandler: onClickHandler)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
  }
}
