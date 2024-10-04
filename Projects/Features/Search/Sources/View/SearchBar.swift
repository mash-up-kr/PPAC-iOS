//
//  SearchBar.swift
//  DesignSystem
//
//  Created by 리나 on 2024/06/29.
//

import SwiftUI
import ResourceKit

struct SearchBar: View {
  @Binding var text: String
  
  var body: some View {
    fakeTextField
      .frame(maxWidth: .infinity)
      .frame(height: 38)
      .background(Color.Background.assistive)
      .clipShape(RoundedRectangle(cornerRadius: 10))
  }
  
  private var fakeTextField: some View {
    HStack(spacing: 12) {
      ResourceKitAsset.Icon.search.swiftUIImage
      
      TextField("찾고 싶은 밈 있어?", text: $text)
      
      Spacer()
      
      Button(action: {
        text = ""
      }, label: {
        ResourceKitAsset.Icon.deleteTextField.swiftUIImage
      })
      .opacity(text.isEmpty ? 0 : 1)
    }
    .padding(.horizontal, 16)
  }
}
