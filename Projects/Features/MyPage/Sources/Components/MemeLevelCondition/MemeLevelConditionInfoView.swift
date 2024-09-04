//
//  MemeLevelConditionInfoView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/07/03.
//

import SwiftUI
import ResourceKit
import DesignSystem

struct MemeLevelConditionInfoView: View {
  let level: MemeLevelType
  let conditionCount: Int
  
  var isCompletedLevel: Bool {
    return level == .level4 && conditionCount > 20
  }
  
  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      confitionInfoView
      Spacer()
      conditionCountChipView
    }
    .padding(.horizontal, 20)
    .padding(.top, 16)
    .padding(.bottom, 20)
    .background {
      RoundedCorners(radius: 20, corners: [.topLeft, .topRight])
        .stroke(Color.Border.tertiary, lineWidth: 1, fill: Color.Background.assistive)
    }
    .padding(.horizontal, 20)
  }
  
  var confitionInfoView: some View {
    VStack(alignment: .leading, spacing: 4) {
      titleLabel
      descriptionLabel
    }
  }
  
  var conditionCountChipView: some View {
    if isCompletedLevel {
      AnyView(completedChipview)
    } else {
      AnyView(countChipView)
    }
  }
  
  var countChipView: some View {
    HStack {
      Text("\(conditionCount)")
        .foregroundStyle(Color.Text.brand)
        .padding(.leading, 8)
      Text("/20")
        .foregroundStyle(Color.Text.tertiary)
        .offset(x: -8, y: 0)
    }
    .background {
      RoundedRectangle(cornerRadius: 30, style: .continuous)
        .foregroundStyle(Color.Background.white)
        .frame(width: 56, height: 27)
    }
    .font(Font.Body.Large.semiBold)
  }
  
  var completedChipview: some View {
    HStack(alignment: .center) {
      ResourceKitAsset.Icon.check.swiftUIImage
        .resizable()
        .renderingMode(.template)
        .frame(width: 12, height: 12)
        .padding(.trailing, -4)
      Text("달성완료")
        .font(Font.Body.Medium.semiBold)
    }
    .background {
      RoundedRectangle(cornerRadius: 30, style: .continuous)
        .foregroundStyle(Color.Background.white)
        .frame(width: 85, height: 27)
    }
    .foregroundStyle(Color.Text.tertiary)
    .padding(.vertical, 5)
    .padding(.horizontal, 10)
  }
  
  var titleText: String {
    return level == .level4 ? "최종 레벨 달성 미션" : "레벨업하고 싶다면"
  }
  
  var titleLabel: some View {
    Text(titleText)
      .foregroundStyle(Color.Text.tertiary)
      .font(Font.Body.Medium.semiBold)
  }
  
  var descriptionLabel: some View {
    Text(level.levelConditionText)
      .foregroundStyle(Color.Text.primary)
      .font(Font.Heading.Small.semiBold)
  }
}

#Preview {
  MemeLevelConditionInfoView(level: .level2, conditionCount: 12)
}
