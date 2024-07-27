//
//  MyPagePregressView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/07/21.
//

import SwiftUI

struct MyPagePregressView: View {
  @Binding var isRefreshCompleted: Bool
  var body: some View {
    if !isRefreshCompleted {
      VStack {
        ProgressView()
          .padding(.top, 80)
      }
    }
  }
}
