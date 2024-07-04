//
//  MemeLevelConditionInfoView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/07/03.
//

import SwiftUI
import ResourceKit
import PPACUtil

struct MemeLevelConditionInfoView: View {
  let conditionCount: Int
  
  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      confitionInfoView
      Spacer()
      countChipView
    }
    .padding(.horizontal, 20)
    .padding(.top, 16)
    .padding(.bottom, 20)
    .background {
      RoundedCorner(radius: 20, corners: [.topLeft, .topRight])
        .stroke(Color.Border.tertiary, lineWidth: 1, fill: Color.Background.assistive)
    }
  }
  
  var confitionInfoView: some View {
    VStack(alignment: .leading, spacing: 4) {
      titleLabel
      descriptionLabel
    }
  }
  
  var countChipView: some View {
    HStack {
      Text("\(conditionCount)")
        .foregroundStyle(Color.Text.brand)
        .padding(.leading, 5)
      Text("/20")
        .foregroundStyle(Color.Text.tertiary)
        .offset(x: -8, y: 0)
    }.background {
      RoundedRectangle(cornerRadius: 30, style: .continuous)
        .foregroundStyle(Color.Background.white)
        .frame(width: 56, height: 30)
    }
    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
  }
  
  var titleLabel: some View {
    Text("다음 레벨 달성 조건")
      .foregroundStyle(Color.Text.tertiary)
      .font(Font.Body.Medium.semiBold)
  }
  
  var descriptionLabel: some View {
    Text("밈 20번 공유하기")
      .foregroundStyle(Color.Text.primary)
      .font(Font.Heading.Small.semiBold)
  }
}

#Preview {
  MemeLevelConditionInfoView(conditionCount: 15)
}
