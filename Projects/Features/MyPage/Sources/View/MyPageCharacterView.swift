//
//  MyPageCharacterView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit

struct MyPageCharacterView: View {
  let level: MemeLevelType
  let description: String
  var body: some View {
    SpeechBalloonView(description: description)
    level.levelCharacterImage
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
      .font(Font.Body.Xlarge.semiBold)
      .padding(.horizontal, 20)
      .padding(.vertical, 15)
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
  MyPageCharacterView(level: .level3, description: "폼 미쳤따아아아아아아ㅏㅏ")
}
