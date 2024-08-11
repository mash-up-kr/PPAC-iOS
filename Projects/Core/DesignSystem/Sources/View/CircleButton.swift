//
//  CircleButtonView.swift
//  DesignSystem
//
//  Created by 김종윤 on 7/9/24.
//

import SwiftUI

import ResourceKit


public struct CircleButton: View {
  let width: CGFloat
  let height: CGFloat
  let image: SwiftUI.Image
  let shadowColor: SwiftUI.Color
  let action: () -> Void
  
  public init(
    width: CGFloat,
    height: CGFloat,
    image: SwiftUI.Image,
    shadowColor: SwiftUI.Color = Color.Shadow.primary,
    action: @escaping () -> Void
  ) {
    self.width = width
    self.height = height
    self.image = image
    self.shadowColor = shadowColor
    self.action = action
  }
  
  public var body: some View {
    Button(action: action) {
      Circle()
        .foregroundStyle(.white)
        .overlay {
          self.image
            .resizable()
            .scaledToFill()
            .frame(width: 20, height: 20, alignment: .center)
        }
        .frame(width: self.width, height: self.height,alignment: .center)
        .shadow(color: shadowColor, radius: 20)
    }
  }
}

#Preview {
  CircleButton(
    width: 42,
    height: 42,
    image: ResourceKitAsset.Icon.copy.swiftUIImage,
    shadowColor: Color.Shadow.orange
  ) {
    print("Copy~~")
  }
}

