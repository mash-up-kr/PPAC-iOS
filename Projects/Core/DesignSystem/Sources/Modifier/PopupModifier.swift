//
//  PopupModifier.swift
//  DesignSystem
//
//  Created by 김종윤 on 7/27/24.
//

import SwiftUI
import PopupView

import ResourceKit

struct PopupModifier: ViewModifier {
  @Binding var isActive: Bool
  let image: SwiftUI.Image?
  let text: String
  
  func body(content: Content) -> some View {
    content
      .popup(isPresented: $isActive) {
        FloatingView(
          image: image,
          text: text
        )
      } customize: {
        $0.type(.floater())
          .position(.top)
          .animation(.spring())
          .autohideIn(2.0)
      }
  }
}
