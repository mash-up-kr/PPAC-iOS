//
//  CircleCopyButton.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit

public struct CircleCopyButton: View {
  public init() { }
  public var body: some View {
    Circle()
      .foregroundStyle(.white)
      .overlay {
        ResourceKitAsset.Icon.copy.swiftUIImage
          .resizable()
          .scaledToFill()
          .frame(width: 20, height: 20, alignment: .center)
      }
      .frame(width: 42, height: 42, alignment: .center)
  }
}

#Preview {
  CircleCopyButton()
}
