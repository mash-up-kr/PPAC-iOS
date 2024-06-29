//
//  MimCategoryView.swift
//  DesignSystem
//
//  Created by 리나 on 2024/06/30.
//

import SwiftUI
import ResourceKit

public struct MimCategoryView: View {
  public let title: String
  public let categories: [String]
  
  public init(title: String, categories: [String]) {
    self.title = title
    self.categories = categories
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text(title)
          .font(Font.Body.Small.semiBold)
          .foregroundColor(Color.Text.tertiary)
        
        Spacer()
      }
      .padding(.top, 4)
      .padding(.bottom, 16)
      .padding(.horizontal, 20)
      
      CategoryTagView(categories: categories)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
  }
}
