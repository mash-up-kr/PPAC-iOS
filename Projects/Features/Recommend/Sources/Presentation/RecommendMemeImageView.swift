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
import PPACAnalytics

struct RecommendMemeImagesView: View {
  @Binding var currentMeme: MemeDetail?
  
  @State var value: CGFloat = 0
  
  @State var imageStatusList: [String : Bool] = [:]
  
  var memes: [MemeDetail]
  var isMemeInfoHidden: Bool
  
  public var body: some View {
    VStack(spacing: 0) {
      ScrollView(.horizontal) {
        ZStack {
          // Image
          LazyHStack(spacing: 0) {
            ForEach(memes, id: \.self) { meme in
              MemeImageView(
                imageUrl: meme.imageUrlString,
                isDimmed: meme.id != currentMeme?.id,
                isLoadingImage: binding(for: meme.id)
              )
              .animation(.smooth, value: meme)
            }
          }
          
          // Border
          HStack(spacing: 0) {
            ForEach(memes, id: \.self) { meme in
              MemeImageBorderView(
                isLoadingImage: binding(for: meme.id)
              )
              .animation(.smooth, value: meme)
            }
          }
        }
        .scrollTargetLayout()
        .recommendSkeleton(
          isShow: memes.isEmpty,
          radius: 20,
          width: memes.isEmpty ? 270 : .infinity,
          height: 310
        )
      }
      .scrollIndicators(.never)
      .scrollTargetBehavior(.viewAligned)
      .scrollPosition(id: $currentMeme)
      .contentMargins(.horizontal, 60.0)
      .padding(.bottom, 16)
      
      if let currentMeme, isMemeInfoHidden == false {
        Text(currentMeme.title)
          .font(Font.Heading.Small.medium)
          .foregroundColor(Color.Text.primary)
          .padding(.bottom, 4)
        
        HashTagView(keywords: currentMeme.keywords)
          .onTapGesture {
            PPACAnalytics.shared
              .log(
                interaction: .click,
                event: .tag,
                page: .recommend
              )
          }
      } else {
        EmptyView()
          .recommendSkeleton(isShow: true, radius: 4, width: 200, height: 16)
      }
    }
    .onChange(of: memes) { _, value in
      if let currentMeme {
        let current = value.first(where: {
          $0.id == currentMeme.id
        })
        self.currentMeme = current
       
      } else {
        self.currentMeme = memes.first
        memes.forEach { meme in
          imageStatusList[meme.id] = false
        }
      }
    }
  }
  
  func binding(for key: String) -> Binding<Bool> {
    return Binding(
      get: {
        return self.imageStatusList[key] ?? false
      },
      set: {
        self.imageStatusList[key] = $0
      }
    )
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
    isMemeInfoHidden: false
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
