//
//  View+Extension.swift
//  PPACUtil
//
//  Created by 장혜령 on 2024/07/04.
//

import SwiftUI

import ResourceKit

public extension View {
  func cornerRadius(
    _ radius: CGFloat,
    corners: UIRectCorner
  ) -> some View {
    clipShape(RoundedCorners(radius: radius, corners: corners))
  }
}

public extension View {
  func popup(
    isActive: Binding<Bool>,
    image: SwiftUI.Image?,
    text: String
  ) -> some View {
    self.modifier(
      PopupModifier(isActive: isActive, image: image, text: text)
    )
  }
}
