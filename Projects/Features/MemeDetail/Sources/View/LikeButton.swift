//
//  LikeButton.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI

import ResourceKit
import DesignSystem
import Lottie

public struct LikeButton: View {
  
  // MARK: - Properties
  
  @Binding var reactionCount: Int
  @State var playbackMode: LottiePlaybackMode = .paused(at: .progress(100))
  
  private let didTapped: (() -> Void)?
  
  // MARK: - Initializers
  
  init(
    reactionCount: Binding<Int>,
    didTapped: (() -> Void)?
  ) {
    self._reactionCount = reactionCount
    self.didTapped = didTapped
  }
  
  // MARK: - UI
  
  public var body: some View {
    HStack(alignment: .center, spacing: 6) {
      iconView
      countLabel
    }
    .onTapGesture(perform: {
      playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .playOnce))
      self.didTapped?()
    })
    .frame(maxWidth: .infinity)
    .frame(height: 46, alignment: .center)
    .background(Color.Skeleton.primary)
    .cornerRadius(10)
    .clipped(antialiased: true)
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
      .font((reactionCount > 0) ? Font.Heading.Medium.bold : Font.Family2.outLine)
      .foregroundColor((reactionCount > 0) ? Color.Text.brand : Color.Text.primary)
  }
}

#Preview {
  @State var count: Int = 1
  return LikeButton(reactionCount: $count, didTapped: nil)
}
