//
//  FakeSearchBar.swift
//  DesignSystem
//
//  Created by 리나 on 2024/06/29.
//

import SwiftUI
import ResourceKit

struct FakeSearchBar: View {
  let placeHolder: String
  
  init(placeHolder: String) {
    self.placeHolder = placeHolder
  }
  
  var body: some View {
    fakeTextField
      .frame(maxWidth: .infinity)
      .frame(height: 44)
      .background(Color.Background.assistive)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .padding(.horizontal, 20)
      .padding(.vertical, 16)
  }
  
  private var fakeTextField: some View {
    HStack(spacing: 12) {
      ResourceKitAsset.Icon.search.swiftUIImage
      
      Text(placeHolder)
        .font(Font.Body.Large.medium)
        .foregroundColor(Color.Text.tertiary)
      
      Spacer()
    }
    .padding(.horizontal, 16)
  }
}
