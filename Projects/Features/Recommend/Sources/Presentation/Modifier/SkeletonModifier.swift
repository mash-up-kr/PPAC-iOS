//
//  SkeletonModifier.swift
//  Recommend
//
//  Created by 김종윤 on 8/8/24.
//

import SwiftUI
import SkeletonUI

import ResourceKit

struct SkeletonModifier: ViewModifier {
  let isShow: Bool
  let radius: CGFloat
  let width: CGFloat?
  let height: CGFloat?
  
  func body(content: Content) -> some View {
    content
      .skeleton(
        with: isShow,
        animation: .linear(duration: 2, delay: 0, speed: 1),
        appearance: .gradient(
          .linear,
          color: Color.Skeleton.home,
          background: Color.Skeleton.homeback,
          radius: 1
        ),
        shape: .rounded(.radius(radius))
      )
      .frame(width: width, height: height)
  }
}
