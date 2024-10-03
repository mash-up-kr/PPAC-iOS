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
import PPACUtil

import Lottie

struct RecommendMemeButtonView : View {
  @State var playbackMode: LottiePlaybackMode = .paused
  @State var likeTapCnt: Int = 0
  @State var likeTapMemeId: String? = nil
  @State var throttler = Throttler(seconds: 3.0)
  
  @Binding var meme: MemeDetail?
  
  let isOverlapView: Bool
  let reactionButtonTapped: (String?, Int) -> Void
  let copyButtonTapped: () -> Void
  let shareButtonTapped: () -> Void
  let saveButtonTapped: () -> Void
  
  public var body: some View  {
    HStack {
      LikeButton(
        isReaction: meme?.isReaction,
        reactionCount: meme?.reaction,
        didTapped: {
          playbackMode = .playing(
            .fromProgress(0, toProgress: 0.7, loopMode: .playOnce)
          )
          likeTapMemeId = meme?.id
          likeTapCnt += 1
          meme?.reaction += 1
          meme?.isReaction = true
          
          throttler.throttle {
            self.reactionButtonTapped(likeTapMemeId, likeTapCnt)
            likeTapMemeId = nil
            likeTapCnt = 0
          }
        }
      )
      .overlay {
        LottieView(animation: AnimationAsset.kkEffect.animation)
          .playbackMode(playbackMode)
          .animationDidFinish { _ in
            playbackMode = .paused
          }
          .frame(width: 200, height: 200, alignment: .center)
          .offset(y: -115)
          .allowsHitTesting(false)
      }
      
      copyButton(copyButtonTapped)
      
      shareButton(shareButtonTapped)
      
      saveButton(isFarmemed: meme?.isFarmemed ?? false) {
        saveButtonTapped()
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 30)
    .background(
      LinearGradient(
        colors: [
          Color.Background.brandsubassistive.opacity(0),
          isOverlapView
          ? Color.Background.brandsubassistive
          : Color.Background.brandsubassistive.opacity(0)
        ],
        startPoint: .top,
        endPoint: .bottom
      )
    )
    .onChange(of: meme?.id) {
      // 쓰로틀링 중에 밈이 변경되면 기다리는 것을 중단하고 바로 서버로 요청
      throttler.cancel()
      self.reactionButtonTapped(likeTapMemeId, likeTapCnt)
      likeTapMemeId = nil
      likeTapCnt = 0
    }
  }
}

func copyButton(_ copyAction: @escaping () -> Void) -> some View {
  CircleButton(
    width: 50,
    height: 50,
    image: ResourceKitAsset.Icon.copy.swiftUIImage,
    shadowColor: Color.Shadow.orange,
    action: copyAction
  )
}

func shareButton(_ shareAction: @escaping () -> Void) -> some View {
  CircleButton(
    width: 50,
    height: 50,
    image: ResourceKitAsset.Icon.share.swiftUIImage,
    shadowColor: Color.Shadow.orange,
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
    shadowColor: Color.Shadow.orange,
    action: saveAction
  )
}

#Preview {
  return RecommendMemeButtonView(
    meme: .constant(MemeDetail.mock),
    isOverlapView: true,
    reactionButtonTapped: {_, _ in },
    copyButtonTapped: { print("copy~~") },
    shareButtonTapped: { print("share~~") },
    saveButtonTapped: { print("save~~~") }
  )
}
