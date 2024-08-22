//
//  View+Extenstion.swift
//  Recommend
//
//  Created by 김종윤 on 7/13/24.
//

import SwiftUI

extension View {
  @ViewBuilder
  func onReadSize(_ perform: @escaping (CGSize) -> Void) -> some View {
    self.customBackground {
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    }
    .onPreferenceChange(SizePreferenceKey.self, perform: perform)
  }
  
  @ViewBuilder
  func customBackground<V: View>(alignment: Alignment = .center, @ViewBuilder content: () -> V) -> some View {
    self.background(alignment: alignment, content: content)
  }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}

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

extension View {
  func searchSkeleton(
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
