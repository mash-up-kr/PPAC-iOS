//
//  View+Extension.swift
//  PPACUtil
//
//  Created by 장혜령 on 2024/07/04.
//

import SwiftUI

public extension View {
  func cornerRadius(
    _ radius: CGFloat,
    corners: UIRectCorner
  ) -> some View {
    clipShape(RoundedCorners(radius: radius, corners: corners))
  }
}

public extension View {
  func copyPopup(isActive: Binding<Bool>) -> some View {
    self.modifier(CopyPopupModifier(isActive: isActive))
  }
  
  func farmemePopup(
    isActive: Binding<Bool>,
    isFarmeme: Binding<Bool>
  ) -> some View {
    self.modifier(FarmemePopupModifier(isActive: isActive, isFarmemed: isFarmeme))
  }
}
