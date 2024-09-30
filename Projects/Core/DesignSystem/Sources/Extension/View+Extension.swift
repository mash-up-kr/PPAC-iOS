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
  
  // MARK: - Keyboard
  func endTextEditing() {
    UIApplication.shared.sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: nil,
      from: nil,
      for: nil
    )
  }
  
  func onKeyboardChange(_ action: @escaping (Bool) -> Void) -> some View {
    self.onAppear {
      NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
        action(true)
      }
      NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
        action(false)
      }
    }
    .onDisappear {
      NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
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


