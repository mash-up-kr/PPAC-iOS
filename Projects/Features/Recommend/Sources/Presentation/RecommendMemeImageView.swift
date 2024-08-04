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
  @Binding var currentMeme: MemeDetail?
  
  @State var value: CGFloat = 0
  
  var memes: [MemeDetail]
  var isTagHidden: Bool = false
  
  public var body: some View {
    VStack(spacing: 0) {
      ScrollView(.horizontal) {
        ZStack {
          // Image
          LazyHStack(spacing: 0) {
            ForEach(memes, id: \.self) { meme in
              MemeImageView(
                imageUrl: meme.imageUrlString,
                isDimmed: meme.id != currentMeme?.id
              )
              .scrollTransition { content, phase in
                content
                  .offset(x: phase.value * -3)
                  .scaleEffect(phase.isIdentity ? 1 : 0.9)
                  .blur(radius: phase.isIdentity ? 0 : 1)
              }
              .animation(.smooth, value: meme)
            }
          }
          
          // Border
          HStack(spacing: 0) {
            ForEach(memes, id: \.self) { meme in
              RoundedRectangle(cornerRadius: 20)
                .inset(by: 1)
                .stroke(Color.Border.primary, lineWidth: 2)
                .scrollTransition { content, phase in
                  content
                    .offset(x: phase.value * -3)
                    .scaleEffect(phase.isIdentity ? 1 : 0.905)
                }
                .animation(.smooth, value: meme)
            }
          }
        }
        .frame(height: 310)
        .scrollTargetLayout()
      }
      .scrollIndicators(.never)
      .scrollTargetBehavior(.viewAligned)
      .scrollPosition(id: $currentMeme)
      .contentMargins(.horizontal, 60.0)
      .padding(.top, 36)
      .padding(.bottom, 20)
      
      if let currentMeme, isTagHidden == false {
        HashTagView(keywords: currentMeme.keywords)
      }
    }
    .onAppear {
      currentMeme = memes.first
    }
    .onChange(of: memes) { _, value in
      let current = value.first(where: {
        $0.id == currentMeme?.id
      })
      currentMeme = current
    }
  }
}

#Preview {
  RecommendMemeImagesView(
    currentMeme: .constant(
      MemeDetail(
        id: "668a44950289555e368174a6",
        title: "심란한 명수옹",
        keywords: ["공부", "학생", "시험기간"],
        imageUrlString: "https://ppac-meme.s3.ap-northeast-2.amazonaws.com/17207014936770.png",
        source: "깃허브",
        isTodayMeme: true,
        reaction: 4,
        isFarmemed: false,
        isReaction: false
      )
    ),
    memes: [
      MemeDetail(
        id: "668a44950289555e368174a6",
        title: "심란한 명수옹",
        keywords: ["공부", "학생", "시험기간"],
        imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
        source: "깃허브",
        isTodayMeme: true,
        reaction: 4,
        isFarmemed: false,
        isReaction: false
      ),
      MemeDetail(
        id: "2",
        title: "울고 싶을 뿐입니다.",
        keywords: ["슬픔", "고양이", "동물", "눈물", "억울", "웃긴", "웃긴", "웃긴", "웃긴"],
        imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
        source: "깃허브",
        isTodayMeme: true,
        reaction: 1,
        isFarmemed: false,
        isReaction: false
      ),
      MemeDetail(
        id: "3",
        title: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ",
        keywords: ["웃긴", "동물", "눈물", "룰루"],
        imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
        source: "깃허브",
        isTodayMeme: true,
        reaction: 0,
        isFarmemed: false,
        isReaction: false
      ),
      MemeDetail(
        id: "4",
        title: "나는 공부를 찢어",
        keywords: ["공부", "학생", "시험기간"],
        imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
        source: "깃허브",
        isTodayMeme: true,
        reaction: 4,
        isFarmemed: false,
        isReaction: false
      ),
      MemeDetail(
        id: "5",
        title: "나는 공부를 찢어",
        keywords: ["공부", "학생", "시험기간"],
        imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
        source: "깃허브",
        isTodayMeme: true,
        reaction: 4,
        isFarmemed: false,
        isReaction: false
      )
    ],
    isTagHidden: false
  )
}
