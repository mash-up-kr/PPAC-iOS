//
//  RoundedCorners.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/07/04.
//

import SwiftUI

public struct RoundedCorners: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
  public init(radius: CGFloat, corners: UIRectCorner) {
    self.radius = radius
    self.corners = corners
  }
  
  public func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}
