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
  let reactionButtonTapped: () -> Void
  let copyButtonTapped: () -> Void
  let shareButtonTapped: () -> Void
  let saveButtonTapped: () -> Void
  
  public var body: some View  {
    HStack {
      likeButton(reactionButtonTapped)
      copyButton(copyButtonTapped)
      shareButton(shareButtonTapped)
      saveButton(saveButtonTapped)
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

func likeButton(_ likeAction: @escaping () -> Void) -> some View {
  Button(action: likeAction) {
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

func copyButton(_ copyAction: @escaping () -> Void) -> some View {
  CircleButton(
    width: 50,
    height: 50,
    image: ResourceKitAsset.Icon.copy.swiftUIImage,
    action: copyAction
  )
}

func shareButton(_ shareAction: @escaping () -> Void) -> some View {
  CircleButton(
    width: 50,
    height: 50,
    image: ResourceKitAsset.Icon.share.swiftUIImage,
    action: shareAction
  )
}

func saveButton(_ saveAction: @escaping () -> Void) -> some View {
  CircleButton(
    width: 50,
    height: 50,
    image: ResourceKitAsset.Icon.stroke.swiftUIImage,
    action: saveAction
  )
}

#Preview {
  RecommendMemeButtonView(
    reactionButtonTapped: { print("reaction~~") },
    copyButtonTapped: {print("copy~~")},
    shareButtonTapped: {print("share~~")},
    saveButtonTapped: {print("save!!")}
  )
}
