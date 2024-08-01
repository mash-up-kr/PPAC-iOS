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
  
  private let reactionCount: Int
  private let didTapped: () -> Void
  
  // MARK: - Initializers
  
  public init(
    reactionCount: Int?,
    didTapped: @escaping () -> Void
  ) {
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
    .shadow(
      color: Color.Background.primary.opacity(0.05),
      radius: 20
    )
    .clipped(antialiased: true)
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
      LottieView(animation: AnimationAsset.kkButtonActive.animation)
        .playbackMode(playbackMode)
        .animationDidFinish { _ in
          playbackMode = .paused(at: .progress(100))
        }
        .frame(width: 44, height: 22)
    }
  }
  
  @ViewBuilder
  var countLabel: some View {
    Text("\((reactionCount > 0) ? "+\(reactionCount)" : "개웃겨")")
      .font(
        (reactionCount > 0) ? Font.Heading.Medium.bold :Font.Family2.outLine
      )
      .foregroundColor(
        (reactionCount > 0) ? Color.Text.brand : Color.Text.primary
      )
  }
}

#Preview {
  var count: Int = 0
  
  return LikeButton(reactionCount: count, didTapped: { })
}
