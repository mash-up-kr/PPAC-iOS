//
//  MemeLevelConditionView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit

struct MemeLevelConditionView: View {
  let conditionCount: Int
  
  var body: some View {
    VStack {
      MemeLevelConditionInfoView(conditionCount: conditionCount)
      MemeLevelConditionCheckView(memeLevel: .level3)
        .offset(x: 0, y: -10)
    }
    .padding(.horizontal, 20)
    .padding(.top, 16)
    .padding(.bottom, 40)
  }
  
  var divider: some View {
    Rectangle()
      .frame(width: .infinity, height: 2)
      .foregroundStyle(Color.Border.secondary)
  }
  
  var memeCountChipView: some View {
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
    .padding(.vertical, 5)
    .padding(.horizontal, 10)
  }
}



#Preview {
  MemeLevelConditionView(conditionCount: 10)
  //MemeLevelConditionView(conditionCount: 10)
}
