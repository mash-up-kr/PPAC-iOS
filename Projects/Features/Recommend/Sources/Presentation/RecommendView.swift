//
//  RecommendView.swift
//  Home
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI
import ResourceKit

import PPACModels

public struct RecommendView: View {
  
  @ObservedObject private var viewModel: RecommendViewModel
  
  @State private var memeImageHeight: CGFloat = 0
  @State private var zstackHeight: CGFloat = 0
  @State private var buttonHeight: CGFloat = 0
  
  public init(
    _ viewModel: RecommendViewModel
  ) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    VStack {
      Spacer()
      RecommendHeaderView(
        userLevel: $viewModel.state.userLevel,
        seenMemeCount: $viewModel.state.memeRecommendWatchCount
      )
      
      ZStack {
        VStack {
          let isOverlapView = memeImageHeight + buttonHeight > zstackHeight
          
          RecommendMemeImagesView(
            memes: viewModel.state.recommendMemes,
            isTagHidden: isOverlapView
          ).onReadSize { size in
            memeImageHeight = size.height
          }
          
          Spacer()
        }
        .zIndex(1)
        
        VStack {
          Spacer()
          
          RecommendMemeButtonView()
            .onReadSize { size in
              buttonHeight = size.height
            }
        }
        .zIndex(2)
      }
      .onReadSize { size in
        zstackHeight = size.height
      }
    }
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
  }
}

#Preview {
  RecommendView(
    RecommendViewModel(
      router: nil,
      recommendMemes: [
        MemeDetail(
          id: "668a44950289555e368174a6",
          title: "심란한 명수옹",
          keywords: ["공부", "학생", "시험기간"],
          imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
          source: "깃허브",
          isTodayMeme: true,
          reaction: 4
        ),
        MemeDetail(
          id: "2",
          title: "울고 싶을 뿐입니다.",
          keywords: ["슬픔", "고양이", "동물", "눈물", "억울", "웃긴"],
          imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
          source: "깃허브",
          isTodayMeme: true,
          reaction: 1
        ),
        MemeDetail(
          id: "3",
          title: "ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ",
          keywords: ["웃긴", "동물", "눈물", "룰루"],
          imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
          source: "깃허브",
          isTodayMeme: true,
          reaction: 0
        ),
        MemeDetail(
          id: "4",
          title: "나는 공부를 찢어",
          keywords: ["공부", "학생", "시험기간"],
          imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
          source: "깃허브",
          isTodayMeme: true,
          reaction: 4
        ),
        MemeDetail(
          id: "5",
          title: "나는 공부를 찢어",
          keywords: ["공부", "학생", "시험기간"],
          imageUrlString: "https://avatars.githubusercontent.com/u/26344479?s=64&v=4",
          source: "깃허브",
          isTodayMeme: true,
          reaction: 4
        )
      ],
      user: UserDetail(
        id:"userId",
        deviceId: "deviceId",
        lastSeenMeme:[],
        isDeleted:false,
        watch:3,
        reaction:10,
        save:10,
        share:10,
        memeRecommendWatchCount:2,
        level:1
      )
    )
  )
}
