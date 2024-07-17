//
//  RecommendMemeImageView.swift
//  Recommend
//
//  Created by 김종윤 on 6/30/24.
//
import SwiftUI

import Kingfisher

import DesignSystem
import ResourceKit

import PPACModels

struct RecommendMemeImagesView: View {
  @State private var currentViewingMeme: MemeDetail?
  
  @Binding var currentViewingMemeId: String?
  @Binding var currentViewingMemeReaction: Int?
  
  var memes: [MemeDetail]
  var isTagHidden: Bool = false
  
  public var body: some View {
    VStack(spacing: 0) {
      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(memes, id: \.self) { meme in
            MemeImageView(imageUrl: meme.imageUrlString)
              .overlay {
                if let currentViewingMeme, currentViewingMeme != meme  {
                  RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color.Background.dimmer)
                }
              }
              .animation(.smooth, value: currentViewingMeme)
              .scrollTransition { content, phase in
                content
                  .scaleEffect(phase.isIdentity ? 1.0 : 0.9)
                  .blur(radius: phase.isIdentity ? 0 : 1)
              }
          }
        }
        .frame(height: 310)
        .scrollTargetLayout()
      }
      .scrollIndicators(.never)
      .scrollTargetBehavior(.viewAligned)
      .scrollPosition(id: $currentViewingMeme)
      .contentMargins(.horizontal, 60.0)
      .padding(.top, 36)
      .padding(.bottom, 20)
      .onChange(of: currentViewingMeme) { oldValue, newValue in
        if let newValue {
          self.currentViewingMemeId = newValue.id
          self.currentViewingMemeReaction = newValue.reaction
        }
      }
      
      if let currentViewingMeme, isTagHidden == false {
        HashTagView(keywords: currentViewingMeme.keywords)
      }
    }
    .onAppear {
      self.currentViewingMeme = self.memes.first
      self.currentViewingMemeId = self.currentViewingMeme?.id
      self.currentViewingMemeReaction = self.currentViewingMeme?.reaction
    }
  }
}

#Preview {
  RecommendMemeImagesView(
    currentViewingMemeId: .constant("668a44950289555e368174a6"),
    currentViewingMemeReaction: .constant(0),
    memes: [
      MemeDetail(
        id: "668a44950289555e368174a6",
        title: "심란한 명수옹",
        keywords: ["공부", "학생", "시험기간"],
        imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
        source: "깃허브",
        isTodayMeme: true,
        reaction: 4, 
        isFarmemed: false
      ),
      MemeDetail(
        id: "2",
        title: "울고 싶을 뿐입니다.",
        keywords: ["슬픔", "고양이", "동물", "눈물", "억울", "웃긴", "웃긴", "웃긴", "웃긴"],
        imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
        source: "깃허브",
        isTodayMeme: true,
        reaction: 1,
        isFarmemed: false
      ),
      MemeDetail(
        id: "3",
        title: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ",
        keywords: ["웃긴", "동물", "눈물", "룰루"],
        imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
        source: "깃허브",
        isTodayMeme: true,
        reaction: 0,
        isFarmemed: false
      ),
      MemeDetail(
        id: "4",
        title: "나는 공부를 찢어",
        keywords: ["공부", "학생", "시험기간"],
        imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
        source: "깃허브",
        isTodayMeme: true,
        reaction: 4,
        isFarmemed: false
      ),
      MemeDetail(
        id: "5",
        title: "나는 공부를 찢어",
        keywords: ["공부", "학생", "시험기간"],
        imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
        source: "깃허브",
        isTodayMeme: true,
        reaction: 4,
        isFarmemed: false
      )
    ],
    isTagHidden: false
  )
}
