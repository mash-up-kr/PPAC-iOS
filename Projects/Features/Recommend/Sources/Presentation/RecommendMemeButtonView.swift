//
//  RecommendMemeButtonView.swift
//  Recommend
//
//  Created by 김종윤 on 6/30/24.
//

import SwiftUI

import ResourceKit
import DesignSystem

import PPACModels

import Lottie

struct RecommendMemeButtonView : View {
  @State var playbackMode: LottiePlaybackMode = .paused
  @State var isTapLikeButton: Bool = false
  
  var isReaction: Bool
  var reactionCnt: Int
  var isFarmemed: Bool
  let isOverlapView: Bool
  let reactionButtonTapped: () -> Void
  let copyButtonTapped: () -> Void
  let shareButtonTapped: () -> Void
  let saveButtonTapped: () -> Void
  
  public var body: some View  {
    HStack {
      LikeButton(
        isReaction: isReaction,
        reactionCount: reactionCnt,
        didTapped: {
          self.isTapLikeButton = true
          playbackMode = .playing(
            .fromProgress(0, toProgress: 0.7, loopMode: .playOnce)
          )
          self.reactionButtonTapped()
        }
      )
      .disabled(self.isTapLikeButton)
      .overlay {
        LottieView(animation: AnimationAsset.kkEffect.animation)
          .playbackMode(playbackMode)
          .animationDidFinish { _ in
            self.isTapLikeButton = false
            playbackMode = .paused
          }
          .frame(width: 200, height: 200, alignment: .center)
          .offset(y: -115)
          .allowsHitTesting(false)
      }
      
      copyButton(copyButtonTapped)
      
      shareButton(shareButtonTapped)
      
      saveButton(isFarmemed: isFarmemed) {
        saveButtonTapped()
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 30)
    .background(
      LinearGradient(
        colors: [
          Color.Background.brandsubassistive.opacity(0),
          isOverlapView ? Color.Background.brandsubassistive : Color.Background.brandsubassistive.opacity(0)
        ],
        startPoint: .top,
        endPoint: .bottom
      )
    )
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

func saveButton(
  isFarmemed: Bool,
  _ saveAction: @escaping () -> Void
) -> some View {
  CircleButton(
    width: 50,
    height: 50,
    image: isFarmemed ? ResourceKitAsset.Icon.filled.swiftUIImage : ResourceKitAsset.Icon.stroke.swiftUIImage,
    action: saveAction
  )
}

#Preview {
  var isReaction: Bool = true
  var reactionCnt: Int = 1
  var isFarmemed: Bool = false
  
  return RecommendMemeButtonView(
    isReaction: isReaction,
    reactionCnt: reactionCnt,
    isFarmemed: isFarmemed,
    isOverlapView: true,
    reactionButtonTapped: {
      isReaction = true
      reactionCnt = +1
    },
    copyButtonTapped: { print("copy~~") },
    shareButtonTapped: { print("share~~") },
    saveButtonTapped: {
      isFarmemed.toggle()
    }
  )
}
