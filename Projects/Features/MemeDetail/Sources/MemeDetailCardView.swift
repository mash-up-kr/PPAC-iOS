//
//  MemeDetailCardView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI

import DesignSystem
import PPACModels
import PPACAnalytics
import ResourceKit

import Lottie

struct MemeDetailCardView: View {
  
  // MARK: - Properties
  
  @Binding private var meme: MemeDetail
  @State var playbackMode: LottiePlaybackMode = .paused(at: .progress(100))
  
  private let reactionButtonTapped: (() -> Void)?
  private let isShortCard: Bool
  
  // MARK: - Initializers
  
  init(
    meme: Binding<MemeDetail>,
    isShortCard: Bool,
    reactionButtonTapped: (() -> Void)?
  ) {
    self._meme = meme
    self.reactionButtonTapped = reactionButtonTapped
    self.isShortCard = isShortCard
  }
  
  // MARK: - UI
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      
      Rectangle()
        .frame(width: 330, height: 352)
        .overlay {
          ZStack {
            MemeImageView(imageUrlString: meme.imageUrlString)
            
            if isShortCard {
              shortCardGradation
              
              VStack(spacing: 0) {
                Spacer()
                
                infoView
              }
            }
          }
        }
        .cornerRadius(10)
        .padding(.bottom, isShortCard ? 0 : 25)
      
      if(!isShortCard) {
        infoView
      }
    }
    .frame(maxWidth: 330)
    .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    .padding(.vertical, 12.5)
    .background(Color.Background.white)
    .cornerRadius(20)
    .overlay(
      RoundedRectangle(cornerRadius: 20)
        .inset(by: 1)
        .stroke(.black, lineWidth: 2)
        .frame(maxWidth: 350)
    )
  }
  
  // MARK: - Methods
  
  var infoView: some View {
    VStack(spacing: 0) {
      titleLabel
        .padding(.bottom, 5)
      
      HashTagView(keywords: meme.keywords, isShortCard: isShortCard)
        .padding(.bottom, 11)
        .onTapGesture {
          PPACAnalytics.shared
            .log(
              interaction: .click,
              event: .tag,
              page: .memeDetail
            )
        }
      
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
      .padding(.bottom, 10)
      .padding(.horizontal, 10)
    }
  }
  
  var titleLabel: some View {
    Text(meme.title)
      .font(Font.Heading.Large.semiBold)
      .multilineTextAlignment(.center)
      .foregroundColor(
        isShortCard ? Color.Text.inverse : Color.Text.primary
      )
      .frame(maxWidth: .infinity, alignment: .center)
  }
  
  var subtitleLabel: some View {
    Text("출처: \(self.meme.source)")
      .font(Font.Body.Xsmall.medium)
      .lineLimit(1)
      .foregroundColor(
        isShortCard ? Color.Text.assistive : Color.Icon.assistive
      )
  }
  
  var shortCardGradation: some View {
    Rectangle()
      .opacity(0)
      .background(
        LinearGradient(
          colors: [
            ResourceKitAsset.PrimaryColor.neutral70.swiftUIColor.opacity(0),
            ResourceKitAsset.PrimaryColor.neutral70.swiftUIColor
          ],
          startPoint: .top,
          endPoint: .bottom
        )
      )
  }
  
  private func handleReactionTapped() {
    playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .playOnce))
    reactionButtonTapped?()
  }
}

#Preview {
  @State var mock: MemeDetail = .mock
  
  return VStack {
    MemeDetailCardView(
      meme: $mock,
      isShortCard: false,
      reactionButtonTapped: nil
    )
  }
  .background(.red)
}
