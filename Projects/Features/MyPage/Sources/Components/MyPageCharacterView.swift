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
  
  var body: some View {
    SpeechBalloonView(description: level.speechBalloonText)
    level.levelCharacterImage
      .resizable()
      .frame(width: 225, height: 200, alignment: .center)
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
      .padding(.vertical, 12)
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
  return MyPageCharacterView(level: .level3)
}
