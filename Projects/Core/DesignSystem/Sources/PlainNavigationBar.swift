//
//  PlainNavigationBar.swift
//  DesignSystem
//
//  Created by kimchansoo on 6/29/24.
//
//

import SwiftUI

import ResourceKit

public struct PlainNavigationBar: View {
  
  // MARK: - Properties
  
  public let backHandler: (() -> Void)?
  public let rightActionHandler: (() -> Void)?
  public let hasConfigureButton: Bool
  public let title: String?
  
  // MARK: - Initializers
  
  // MARK: - UI
  
  public var body: some View {
    VStack {
      HStack(alignment: .center, spacing: 0) {
        Button(action: { self.backHandler?() }) {
          ResourceKitAsset.Icon.back.swiftUIImage
        }
        
        Spacer()
        
        if let title {
          Text(title)
            .font(Font.Body.Xlarge.semiBold)
            .lineLimit(1)
            .foregroundColor(Color.Text.primary)
        }
        
        Spacer()
        
        if hasConfigureButton {
          ResourceKitAsset.Icon.setting.swiftUIImage
        }
      }
      .padding(.horizontal, 16)
    }
    .frame(height: 50)
    .background(Color.white.edgesIgnoringSafeArea(.all))
  }
}


public struct PlainNavigationBarModifier: ViewModifier {
  let backHandler: (() -> Void)?
  let rightActionHandler: (() -> Void)?
  let hasConfigureButton: Bool
  let title: String?
  
  public func body(content: Content) -> some View {
    content.overlay {
      VStack(spacing: 0) {
        ZStack {
          HStack {
            Button(action: { self.backHandler?() }) {
              ResourceKitAsset.Icon.back.swiftUIImage
                .resizable()
                .frame(width: 20, height: 20)
            }
            Spacer()
          }
          
          if let title {
            Text(title)
              .font(Font.Body.Xlarge.semiBold)
              .lineLimit(1)
              .foregroundColor(Color.Text.primary)
              .frame(maxWidth: .infinity)
              .multilineTextAlignment(.center) // 중앙 정렬
          }
          
          HStack {
            Spacer()
            if hasConfigureButton {
              ResourceKitAsset.Icon.setting.swiftUIImage
                .resizable()
                .frame(width: 20, height: 20)
            }
          }
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .background(Color.clear.edgesIgnoringSafeArea(.top))
        .padding(.bottom, 0)
        
        Spacer()
      }
    }
  }
}

public extension View {
  func plainNavigationBar(
    backHandler: (() -> Void)? = nil,
    rightActionHandler: (() -> Void)? = nil,
    hasConfigureButton: Bool = false,
    title: String? = nil
  ) -> some View {
    self.modifier(PlainNavigationBarModifier(
      backHandler: backHandler,
      rightActionHandler: rightActionHandler,
      hasConfigureButton: hasConfigureButton,
      title: title
    ))
  }
}

#Preview {
  VStack {
    Text("Hello, World!")
    Spacer()
  }
  .plainNavigationBar(
    backHandler: { print("Back button tapped") },
    rightActionHandler: { print("Right action tapped") },
    hasConfigureButton: true,
    title: "Title"
  )
}

