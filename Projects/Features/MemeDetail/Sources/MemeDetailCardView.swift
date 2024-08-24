//
//  MemeDetailCardView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI

import DesignSystem
import PPACModels
import ResourceKit

import Lottie

struct MemeDetailCardView: View {
  
  // MARK: - Properties
  
  @Binding private var meme: MemeDetail
  @State var playbackMode: LottiePlaybackMode = .paused(at: .progress(100))
  
  private let reactionButtonTapped: (() -> Void)?
  
  // MARK: - Initializers
  
  init(
    meme: Binding<MemeDetail>,
    reactionButtonTapped: (() -> Void)?
  ) {
    self._meme = meme
    self.reactionButtonTapped = reactionButtonTapped
  }
  
  // MARK: - UI
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      
      MemeImageView(imageUrlString: meme.imageUrlString)
        .padding(.bottom, 25)
      
      titleLabel
        .padding(.bottom, 5)
      
      HashTagView(keywords: meme.keywords)
        .padding(.bottom, 11)
      
      subtitleLabel
        .padding(.bottom, 20)
      
      LikeButton(
        isReaction: meme.isReaction, reactionCount: meme.reaction
      ) {
        self.handleReactionTapped()
      }
      .overlay(content: {
        LottieView(animation: AnimationAsset.kkEffect.animation)
          .playbackMode(playbackMode)
          .animationDidFinish { _ in
            playbackMode = .paused(at: .progress(100))
          }
          .offset(y: -50)
      })
      .padding(.bottom, 20)
    }
    .padding(10)
    .background(Color.Background.white)
    .cornerRadius(20)
    .overlay(
      RoundedRectangle(cornerRadius: 20)
        .inset(by: 1)
        .stroke(.black, lineWidth: 2)
    )
  }
  
  // MARK: - Methods
  
  var titleLabel: some View {
    Text(meme.title)
      .font(Font.Heading.Large.semiBold)
      .multilineTextAlignment(.center)
      .foregroundColor(Color.Text.primary)
      .frame(maxWidth: .infinity, alignment: .center)
  }
  
  var subtitleLabel: some View {
    Text("출처: \(self.meme.source)")
      .font(Font.Body.Xsmall.medium)
      .lineLimit(1)
      .foregroundColor(Color.Icon.assistive)
  }
  
  private func handleReactionTapped() {
    playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .playOnce))
    reactionButtonTapped?()
  }
}

#Preview {
  @State var mock: MemeDetail = .mock
  
  return VStack {
    MemeDetailCardView(meme: $mock, reactionButtonTapped: nil)
  }
  .background(.red)
}
