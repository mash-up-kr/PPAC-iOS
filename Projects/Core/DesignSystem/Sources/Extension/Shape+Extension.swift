//
//  Shape+Extension.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/07/04.
//

import SwiftUI

public extension Shape {
  func stroke<StrokeStyle, FillStyle>(
    _ strokeStyle: StrokeStyle,
    lineWidth: CGFloat = 1,
    fill fillStyle: FillStyle
  ) -> some View where StrokeStyle: ShapeStyle, FillStyle: ShapeStyle {
    self
      .stroke(strokeStyle, lineWidth: lineWidth)
      .background(self.fill(fillStyle))
  }
}

