//
//  MyPageView.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI

import DesignSystem
import ResourceKit
import PPACModels

import PopupView

public struct MyPageView: View {
  @ObservedObject private var viewModel: MyPageViewModel
  
  public init(viewModel: MyPageViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack(alignment: .top) {
      ScrollView {
        levelView
        divider
        RecentlyMemeListView(
          memeDetailList: $viewModel.state.lastSeenMemeList,
          memeClickHandler: { meme in
            viewModel.dispatch(type: .onTappedRecentMeme(meme: meme))
          }
        )
        SegmentedTitleView(
          titleItems: viewModel.state.segmentedTitleItems,
          titleItemClickHandler: { title in
            viewModel.dispatch(type: .onTappedSegmentedTitleItem(title: title))
          }
        )
        MemeListView(
          memeDetailList: $viewModel.state.currentMyMemeList,
          memeClickHandler: { meme in
            viewModel.dispatch(type: .onTappedSavedMeme(meme: meme))
          },
          memeCopyHandler: { meme in
            viewModel.dispatch(type: .onTappedCopyButton(meme: meme))
          },
          onAppearLastMemeHandler: {
            viewModel.dispatch(type: .onAppearLastMeme)
          }
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 138)
//        SavedMemeListView(
//          memeDetailList: $viewModel.state.currentMyMemeList,
//          memeClickHandler: { meme in
//            viewModel.dispatch(type: .onTappedSavedMeme(meme: meme))
//          },
//          memeCopyHandler: { meme in
//            viewModel.dispatch(type: .onTappedCopyButton(meme: meme))
//          },
//          onAppearLastMemeHandler: {
//            viewModel.dispatch(type: .onAppearLastMeme)
//          }
//        )
//        .padding(.bottom, 138)
      }
      .onAppear {
        viewModel.dispatch(type: .onAppearMyPageView)
      }
      .refreshable {
        viewModel.dispatch(type: .pullToRefresh)
      }
      .edgesIgnoringSafeArea(.all)
    }
    .popup(
      isActive: $viewModel.state.isActiveCopyPopup,
      image: ResourceKitAsset.Icon.copyFilled.swiftUIImage,
      text: "이미지를 클립보드에 복사했어요"
    )
  }
  
  var levelView: some View {
    VStack {
      settingHeaderView
      MyPageCharacterView(level: viewModel.state.memeLevel)
      levelTitleTextView
      LevelProgressView(level: viewModel.state.memeLevel,
                        conditionCount: viewModel.state.conditionCount)
      MemeLevelConditionView(level: viewModel.state.memeLevel,
                             conditionCount: viewModel.state.conditionCount)
    }
    .background {
      gradientBackgroundView
    }
  }
  
  var gradientBackgroundView: some View {
    LinearGradient(
      gradient: Gradient(
        colors: [Color.Background.brandassistive, Color.Background.white]
      ),
      startPoint: .top, endPoint: .bottom
    )
  }
  
  var settingHeaderView: some View {
    HStack {
      Spacer()
      ResourceKitAsset.Icon.setting.swiftUIImage
        .frame(width: 20, height: 20, alignment: .center)
        .padding(.vertical, 15)
        .padding(.trailing, 20)
        .onTapGesture {
          viewModel.dispatch(type: .settingButtonTapped)
        }
    }
    .padding(.top, 51)
  }
  
  var levelTitleTextView: some View {
    Text(viewModel.state.memeLevel.levelTitleText)
      .font(Font.Family2.outLine)
      .padding(20)
  }
  
  var divider: some View {
    Rectangle()
      .frame(height: 10)
      .foregroundStyle(Color.Skeleton.primary)
      .padding(.bottom, 20)
  }
  
  
  
}




//#Preview {
//  let mockImageList = ["https://plus.unsplash.com/premium_photo-1661892088256-0a17130b3d0d?q=80&w=3560&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//                       "https://plus.unsplash.com/premium_photo-1676955432796-226f504a560b?q=80&w=3333&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//                       "https://images.unsplash.com/photo-1720247521923-f531207d23d8?q=80&w=2667&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", "https://images.unsplash.com/photo-1507146426996-ef05306b995a?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
//  let memeDetailList = (0..<20)
//    .map {
//      MemeDetail(
//        id: "\($0)",
//        title: MemeDetail.mock.title,
//        keywords: MemeDetail.mock.keywords,
//        imageUrlString: mockImageList[$0 % 4],
//        source: MemeDetail.mock.source,
//        isTodayMeme: true,
//        reaction: $0 % 4,
//        isFarmemed: true
//      )
//    }
//  return MyPageView(memeLevel: .level1, memeDetailList: memeDetailList)
//}
