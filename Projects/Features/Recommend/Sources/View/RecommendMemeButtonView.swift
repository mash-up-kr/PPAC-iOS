//
//  RecommendMemeButtonView.swift
//  Recommend
//
//  Created by 김종윤 on 6/30/24.
//

import SwiftUI
import ResourceKit

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
          ResourceKitAsset.Icon.개웃겨.swiftUIImage
        }
      }
  }
}

var copyButton: some View {
  Button(action: {
    print("Copy~")
  }, label: {
    smallButton(image : ResourceKitAsset.Icon.copy.swiftUIImage)
  })
}

var shareButton: some View {
  Button(action: {
    print("Share~")
  }, label: {
    smallButton(image : ResourceKitAsset.Icon.share.swiftUIImage)
  })
}

var saveButton: some View {
  Button(action: {
    print("Save~")
  }, label: {
    smallButton(image : ResourceKitAsset.Icon.stroke.swiftUIImage)
  })
}

private func smallButton(image: SwiftUI.Image) -> some View {
  Circle()
    .foregroundStyle(.white)
    .frame(width: 50, height: 50)
    .overlay {
      image
    }
}
