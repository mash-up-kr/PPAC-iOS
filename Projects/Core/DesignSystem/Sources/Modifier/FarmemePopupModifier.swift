//
//  FarmemePopupModifier.swift
//  DesignSystem
//
//  Created by 김종윤 on 7/26/24.
//

import SwiftUI
import PopupView

import ResourceKit

struct FarmemePopupModifier: ViewModifier {
  @Binding var isActive: Bool
  @Binding var isFarmemed: Bool
  
  func body(content: Content) -> some View {
    content
      .popup(isPresented: $isActive) {
        FloatingView(
          image: isFarmemed ? ResourceKitAsset.Icon.copyFilled.swiftUIImage : nil,
          text: isFarmemed ? "파밈 완료!" : "파밈을 취소했어요"
        )
      } customize: {
        $0.type(.floater())
          .position(.top)
          .animation(.spring())
          .autohideIn(2.0)
      }
  }
}
