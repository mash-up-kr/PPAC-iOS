//
//  LevelProgressView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit
import PPACUtil

struct LevelProgressView: View {
  let level: Int
  private var currentLevelWidth: CGFloat {
    print("UIScreen.screenWidth = \(UIScreen.screenWidth)")
    let width = (UIScreen.screenWidth - 40) / 20.0 * CGFloat(level)
    return width < 95.0 ? 95.0 : width
  }
  
  var body: some View {
    ZStack {
      backgroundProgressView
      foregroundProgressView
      levelView
    }
  }
  
  var levelView: some View {
    HStack {
      ResourceKitAsset.Icon.level1.swiftUIImage
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
      Text("LV.1")
        .font(ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 20))
        .foregroundStyle(Color.Text.inverse)
      Spacer()
    }
    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
  }
  
  var foregroundProgressView: some View {
    HStack {
      RoundedRectangle(cornerRadius: 25, style: .circular)
        .stroke(Color.Border.primary, lineWidth: 2, fill: Color.Background.brand)
        .frame(width: currentLevelWidth, height: 50, alignment: .leading)
      Spacer()
    }
    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
  }
  
  var backgroundProgressView: some View {
    RoundedRectangle(cornerRadius: 25, style: .circular)
      .stroke(Color.Border.secondary, lineWidth: 1, fill: Color.Background.assistive)
      .frame(width: .infinity, height: 50)
      .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
  }
}

extension Shape {
  func stroke<StrokeStyle, FillStyle>(
    _ strokeStyle: StrokeStyle,
    lineWidth: CGFloat = 1,
    fill fillStyle: FillStyle
  ) -> some View where StrokeStyle: ShapeStyle, FillStyle: ShapeStyle {
    self
      .stroke(strokeStyle, lineWidth: lineWidth)
      .background(self.fill(fillStyle))
  }
}


#Preview {
  LevelProgressView(level: 17)
}
