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
  @State var playbackMode: LottiePlaybackMode = .paused(at: .progress(100))
  
  @Binding var meme: MemeDetail?
  
  let reactionButtonTapped: () -> Void
  let copyButtonTapped: () -> Void
  let shareButtonTapped: () -> Void
  let saveButtonTapped: () -> Void
  
  public var body: some View  {
    HStack {
      LikeButton(
        reactionCount: meme?.reaction,
        didTapped: {
          playbackMode = .playing(
            .fromProgress(0, toProgress: 1, loopMode: .playOnce)
          )
          self.reactionButtonTapped()
        }
      )
      .overlay(content: {
        LottieView(animation: AnimationAsset.kkEffect.animation)
          .playbackMode(playbackMode)
          .animationDidFinish { _ in
            playbackMode = .paused(at: .progress(100))
          }
          .offset(y: -50)
      })
      
      copyButton(copyButtonTapped)
      shareButton(shareButtonTapped)
      saveButton(isFarmemed: meme?.isFarmemed ?? false) {
        meme?.isFarmemed.toggle()
        saveButtonTapped()
      }
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
  @State var meme: MemeDetail? = MemeDetail(
    id: "1234",
    title: "안녕하세요!",
    keywords: ["웃김", "재미", "신나"],
    imageUrlString: "https://host.com/asdf",
    source: "종난", 
    isTodayMeme: true,
    reaction: 130,
    isFarmemed: true
  )
  
  return RecommendMemeButtonView(
    meme: $meme,
    reactionButtonTapped: { meme?.reaction += 1 },
    copyButtonTapped: { print("copy~~") },
    shareButtonTapped: { print("share~~") },
    saveButtonTapped: {
      print("isFarmemed: \(meme?.isFarmemed)")
    }
  )
}
