//
//  RecommendMemeButtonView.swift
//  Recommend
//
//  Created by 김종윤 on 6/30/24.
//

import SwiftUI

import ResourceKit
import DesignSystem

struct RecommendMemeButtonView : View {
  public var body: some View  {
    HStack {
      likeButton
      copyButton
      shareButton
      saveButton
    }
    .padding(.vertical, 30)
    .padding(.horizontal, 32)
    .background(
      LinearGradient(
        colors: [
          Color.Background.brandsubassistive.opacity(0),
          Color.Background.brandsubassistive
        ],
        startPoint: .top,
        endPoint: .bottom
      )
    )
  }
}

var likeButton: some View {
  Button(action: {
    print("i like it!")
  }) {
    RoundedRectangle(cornerRadius: 40)
      .foregroundStyle(.white)
      .frame(width: 156 ,height: 50)
      .overlay {
        HStack {
          ResourceKitAsset.Icon.ㅋ.swiftUIImage
          Text("개웃겨")
            .font(Font.Family2.outLine)
            .foregroundStyle(Color.Icon.primary)
        }
      }
  }
}

var copyButton: some View {
  CircleButton(
    width: 50,
    height: 50,
    image: ResourceKitAsset.Icon.copy.swiftUIImage
  ) {
    print("Copy~~")
  }
}

var shareButton: some View {
  CircleButton(
    width: 50,
    height: 50,
    image: ResourceKitAsset.Icon.share.swiftUIImage
  ) {
    print("Share~")
  }
}

var saveButton: some View {
  CircleButton(
    width: 50,
    height: 50,
    image: ResourceKitAsset.Icon.stroke.swiftUIImage
  ) {
    print("Save~")
  }
}

#Preview {
  RecommendMemeButtonView()
}
