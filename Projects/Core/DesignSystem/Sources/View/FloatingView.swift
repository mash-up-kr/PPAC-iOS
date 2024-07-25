//
//  FloatingView.swift
//  DesignSystem
//
//  Created by 김종윤 on 7/25/24.
//

import SwiftUI

import ResourceKit

public struct FloatingView: View {
  var image: SwiftUI.Image?
  var text: String
  
  public init(
    image: SwiftUI.Image?,
    text: String
  ) {
    self.image = image
    self.text = text
  }
  
  public var body: some View {
    HStack {
      image?
        .resizable()
        .frame(width:20, height:20, alignment: .center)
      
      Text(text)
        .foregroundStyle(Color.Text.inverse)
        .font(Font.Body.Large.semiBold)
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 15)
    .background(Color.Background.primary.opacity(0.9))
    .cornerRadius(25)
  }
}

#Preview {
  VStack {
    FloatingView(
      image: ResourceKitAsset.Icon.successFilledBrandcolor.swiftUIImage,
      text: "텍스트가 들어갑니다"
    )
    
    FloatingView(
      image: nil,
      text: "텍스트가 들어갑니다"
    )
  }
}
