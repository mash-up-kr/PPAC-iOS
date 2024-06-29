//
//  MyPageCharacterView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit

struct MyPageCharacterView: View {
  let description: String
  var body: some View {
    SpeechBalloonView(description: description)
    ResourceKitAsset.Icon.level1.swiftUIImage // TODO: 캐릭터 이미지 나오면 변경 필요
      .resizable()
      .frame(width: 190, height: 190, alignment: .center)
  }
}

struct SpeechBalloonView: View {
  let description: String
  var body: some View {
    VStack {
      descriptionView
      speechBubbleTipView
    }
  }
  
  var descriptionView: some View {
    Text(description)
      .font(ResourceKitFontFamily.Pretendard.semiBold.swiftUIFont(size: 20))
      .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
      .background {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
          .foregroundStyle(Color.Background.primary)
      }
      .foregroundStyle(Color.Text.inverse)
  }
  
  var speechBubbleTipView: some View {
    ResourceKitAsset.Icon.speechBubbleTip.swiftUIImage
      .frame(width: 20, height: 12, alignment: .top)
      .offset(x: 0, y: -10)
  }
}

#Preview {
  MyPageCharacterView(description: "폼 미쳤따아아아아아아ㅏㅏ")
}
