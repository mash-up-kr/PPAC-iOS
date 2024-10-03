//
//  View+Extenstion.swift
//  Recommend
//
//  Created by 김종윤 on 7/13/24.
//

import SwiftUI

extension View {
  func recommendSkeleton(
    isShow: Bool,
    radius: CGFloat,
    width: CGFloat? = nil,
    height: CGFloat? = nil
  ) -> some View {
    self.modifier(
      SkeletonModifier(isShow: isShow, radius: radius, width: width, height: height)
    )
  }
}
