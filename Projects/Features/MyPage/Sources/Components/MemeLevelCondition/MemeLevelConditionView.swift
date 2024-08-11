//
//  MemeLevelConditionView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit

struct MemeLevelConditionView: View {
  let level: MemeLevelType
  let conditionCount: Int
  
  var body: some View {
    VStack {
      MemeLevelConditionInfoView(level: level, conditionCount: conditionCount)
      MemeLevelConditionCheckView(level: level, conditionCount: conditionCount)
        .offset(x: 0, y: -10)
    }
    .padding(.top, 16)
    .padding(.bottom, 20)
  }
  
}



#Preview {
  MemeLevelConditionView(level: .level3, conditionCount: 10)
}
