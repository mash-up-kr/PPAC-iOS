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
  let level: MemeLevelType
  let conditionCount: Int
  
  @State private var isAnimation = false
  
  private let minimumWidth: CGFloat = 95.0
  private let horizontalPadding: CGFloat = 20.0
  
  var body: some View {
    ZStack(alignment: .leading) {
      backgroundProgressView
      foregroundProgressView
      levelView
    }
    .frame(height: 44)
    .padding(.horizontal, horizontalPadding)
    .onAppear {
      isAnimation = true
    }
  }
  
  var levelView: some View {
    HStack {
      level.levelBadgeImage
        .padding(.leading, 12)
      Text("LV.\(level.rawValue)")
        .font(Font.Body.Xlarge.semiBold)
        .foregroundStyle(Color.Text.inverse)
      Spacer()
    }
  }
  
  var foregroundProgressView: some View {
    HStack {
      GeometryReader { geometry in
        let currnetlevelWidth = getCurrentLevelWidth(geometry.size.width)
        RoundedRectangle(cornerRadius: 25, style: .circular)
          .stroke(Color.Border.primary, lineWidth: 2, fill: Color.Background.brand)
          .frame(width: isAnimation ? currnetlevelWidth : minimumWidth)
          .animation(.easeInOut(duration: 1.5), value: isAnimation)
      }
    }
  }
  
  var backgroundProgressView: some View {
    RoundedRectangle(cornerRadius: 25, style: .circular)
      .stroke(Color.Border.secondary, lineWidth: 1, fill: Color.Background.assistive)
  }
  
  private func getCurrentLevelWidth(_ viewWidth: CGFloat) -> CGFloat {
    let count = conditionCount > 20 ? 20 : conditionCount
    let width = (viewWidth - minimumWidth) / 20.0 * CGFloat(count)
    return width + minimumWidth
  }
}


#Preview {
  LevelProgressView(level: .level3, conditionCount: 5)
}
