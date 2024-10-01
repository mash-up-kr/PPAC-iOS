//
//  RecommendHeaderView.swift
//  Recommend
//
//  Created by 김종윤 on 6/29/24.
//

import SwiftUI
import SkeletonUI

import ResourceKit

import Lottie

struct RecommendHeaderView: View {
  
  let isLoad: Bool
  let uploadButtonTap: () -> Void
  
  public var body: some View {
    
    VStack(spacing: 0) {
      ResourceKitAsset.Icon.homeLogo.swiftUIImage
        .resizable()
        .frame(width: 106, height: 32, alignment: .center)
        .padding(.bottom, 12)
      
      recommendTitle
      
      if isLoad {
        memeUploadButton(uploadButtonTap)
          .padding(.top, 20)
          .padding(.bottom, 28)
      } else {
        EmptyView()
          .recommendSkeleton(isShow: !isLoad, radius: 4, width: 130, height: 36)
          .padding(.top, 20)
          .padding(.bottom, 28)
      }
    }
  }
}

private var recommendTitle : some View {
  VStack(spacing: 0) {
    Text("NEW! 따끈따끈한 밈")
      .font(Font.Heading.Large.semiBold)
      .padding(.bottom, 4)
    
    Text("최근에 사람들이 올린 밈 구경하세요.")
      .font(Font.Body.Medium.medium)
      .foregroundStyle(Color.Text.secondary)
  }
}

private func memeUploadButton(
  _ uploadButtonTap: @escaping () -> Void
) -> some View {
  @State var playbackMode: LottiePlaybackMode = .paused(at: .progress(100))
  
  return Button(
    action: {
      uploadButtonTap()
    },
    label: {
      LottieView(
        animation: AnimationAsset.uploadLottie.animation
      )
      .looping()
    }
  )
  .buttonStyle(PlainButtonStyle())
  .frame(width: 130, height: 36)
  .contentShape(RoundedRectangle(cornerRadius: 10))
}


#Preview {
  return RecommendHeaderView(
    isLoad: true,
    uploadButtonTap: {
      print("Upload Button Tap!")
    }
  )
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(
    LinearGradient(
      colors: [
        Color.Background.brandassistive,
        Color.Background.brandsubassistive
      ],
      startPoint: .top,
      endPoint: .bottom
    )
  )
  .edgesIgnoringSafeArea(.bottom)
}
