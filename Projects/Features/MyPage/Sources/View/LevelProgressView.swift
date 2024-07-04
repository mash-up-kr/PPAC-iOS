//
//  LevelProgressView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit
import DesignSystem

struct LevelProgressView: View {
  let level: Int
  private let minimumWidth: CGFloat = 95.0
  private var currentLevelWidth: CGFloat {
    let width = (UIScreen.screenWidth - 40) / 20.0 * CGFloat(level)
    return width < minimumWidth ? minimumWidth : width
  }
  
  var body: some View {
    ZStack {
      backgroundProgressView
      foregroundProgressView
      levelView
    }
    .frame(height: 44)
    .padding(.horizontal, 20)
  }
  
  var levelView: some View {
    HStack {
      ResourceKitAsset.Icon.level1.swiftUIImage
        .padding(.leading, 12)
      Text("LV.1")
        .font(Font.Body.Xlarge.semiBold)
        .foregroundStyle(Color.Text.inverse)
      Spacer()
    }
  }
  
  var foregroundProgressView: some View {
    HStack {
      RoundedRectangle(cornerRadius: 25, style: .circular)
        .stroke(Color.Border.primary, lineWidth: 2, fill: Color.Background.brand)
        .frame(width: currentLevelWidth)
      Spacer()
    }
  }
  
  var backgroundProgressView: some View {
    RoundedRectangle(cornerRadius: 25, style: .circular)
      .stroke(Color.Border.secondary, lineWidth: 1, fill: Color.Background.assistive)
  }
}


#Preview {
  LevelProgressView(level: 10)
}
