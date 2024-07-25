//
//  CopyPopupModifier.swift
//  DesignSystem
//
//  Created by 김종윤 on 7/26/24.
//

import SwiftUI
import PopupView

import ResourceKit

struct CopyPopupModifier: ViewModifier {
  @Binding var isActive: Bool
  
  func body(content: Content) -> some View {
    content
      .popup(isPresented: $isActive) {
        FloatingView(
          image: ResourceKitAsset.Icon.copyFilled.swiftUIImage,
          text: "이미지를 클립보드에 복사했어요"
        )
      } customize: {
        $0.type(.floater())
          .position(.top)
          .animation(.spring())
          .autohideIn(2.0)
      }
  }
}
