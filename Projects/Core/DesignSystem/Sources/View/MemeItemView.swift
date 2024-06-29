//
//  MemeItemView.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI

public struct MemeItemView: View {
  public init() { }
  public var body: some View {
    ZStack(alignment: .bottomLeading) {
      VStack {
        Rectangle() // memeImageView가 와야함
          .foregroundStyle(.red)
      }
      HStack {
        Spacer()
        CircleCopyButton()
          .padding(20)
      }
    }
  }
}

#Preview {
  MemeItemView()
}
