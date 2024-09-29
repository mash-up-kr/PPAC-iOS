//
//  LikeButton.swift
//  Recommend
//
//  Created by 김종윤 on 7/18/24.
//

import SwiftUI

import ResourceKit

import Lottie

public struct LikeButton: View {
  // MARK: - Properties
  
  @State var playbackMode: LottiePlaybackMode = .paused(at: .progress(100))
  
  private let isReaction: Bool
  private let reactionCount: Int
  private let didTapped: () -> Void
  
  // MARK: - Initializers
  
  public init(
    isReaction: Bool?,
    reactionCount: Int?,
    didTapped: @escaping () -> Void
  ) {
    self.isReaction = isReaction ?? false
    self.reactionCount = reactionCount ?? 0
    self.didTapped = didTapped
  }
  
  // MARK: - UI
  
  public var body: some View {
    HStack(alignment: .center, spacing: 6) {
      iconView
      countLabel
    }
    .frame(width: 156 ,height: 50, alignment: .center)
    .background(Color.Background.white)
    .cornerRadius(40)
    .clipped(antialiased: true)
    .shadow(color: Color.Shadow.orange, radius: 20)
    .onTapGesture {
      playbackMode = .playing(
        .fromProgress(0, toProgress: 1, loopMode: .playOnce)
      )
      self.didTapped()
    }
  }
  
  @ViewBuilder
  var iconView: some View {
    if reactionCount <= 0 {
      ResourceKitAsset.Icon.ㅋ.swiftUIImage
    } else {
      if isReaction {
        LottieView(animation: AnimationAsset.kkButtonActive.animation)
          .playbackMode(playbackMode)
          .animationDidFinish { _ in
            playbackMode = .paused(at: .progress(100))
          }
          .frame(width: 44, height: 22)
      } else {
        ResourceKitAsset.Icon.ㅋㅋ.swiftUIImage
      }
    }
  }
  
  @ViewBuilder
  var countLabel: some View {
    Text("\((reactionCount > 0) ? "+\(reactionCount)" : "개웃겨")")
      .font(
        (reactionCount > 0) ? Font.Heading.Medium.bold :Font.Family2.outLine
      )
      .foregroundColor(
        (isReaction) ? Color.Text.brand : Color.Text.primary
      )
  }
}

#Preview {
  return VStack {
    LikeButton(
      isReaction: false,
      reactionCount: 0,
      didTapped: {
        print("AA")
      }
    )
    
    LikeButton(
      isReaction: true,
      reactionCount: 1,
      didTapped: {
        print("AA")
      }
    )
  }
}
