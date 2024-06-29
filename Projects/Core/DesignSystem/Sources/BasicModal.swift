//
//  BasicModal.swift
//  DesignSystem
//
//  Created by 리나 on 2024/06/30.
//

import SwiftUI
import ResourceKit

// Thanks to 균
public struct BasicModal<Content: View>: View {
  @Binding var isPresented: Bool
  private let content: () -> Content
  private var opacity: Double
  
  public init(
    isPresented: Binding<Bool>,
    opacity: Double,
    content: @escaping () -> Content
  ) {
    self._isPresented = isPresented
    self.opacity = opacity
    self.content = content
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        if isPresented {
          Color.black.opacity(opacity)
            .onTapGesture {
              self.isPresented.toggle()
            }
            .transition(.opacity)
          
          content()
            .padding(.horizontal, 40)
        }
      }
      .edgesIgnoringSafeArea(.all)
    }
  }
}

extension View {
  public func basicModal<Content: View>(
    isPresented: Binding<Bool>,
    opacity: Double,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    modifier(
      BasicModalModifier(
        content: {
          BasicModal(
            isPresented: isPresented,
            opacity: opacity,
            content: content
          )
        }
      )
    )
  }
}

fileprivate struct BasicModalModifier<SheetContent>: ViewModifier where SheetContent: View {
  var content: () -> BasicModal<SheetContent>
  
  func body(content: Content) -> some View {
    ZStack {
      content
      self.content()
    }
  }
}
