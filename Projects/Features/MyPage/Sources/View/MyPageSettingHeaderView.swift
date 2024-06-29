//
//  MyPageSettingHeaderView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit

struct MyPageSettingHeaderView: View {
  var body: some View {
    HStack {
      Spacer()
      ResourceKitAsset.Icon.setting.swiftUIImage
        .frame(width: 20, height: 20, alignment: .center)
        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 20))
    }
  }
}

#Preview {
  MyPageSettingHeaderView()
}
