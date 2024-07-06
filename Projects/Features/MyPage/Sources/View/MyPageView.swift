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

public struct MyPageView: View {
  private let memeLevel: MemeLevelType
  private let memeDetailList: [MemeDetail] = Array(repeating: MemeDetail.mock, count: 10)
  
  public init(memeLevel: MemeLevelType) {
    self.memeLevel = memeLevel
  }
  
  public var body: some View {
    ScrollView {
      settingHeaderView
      MyPageCharacterView(level: memeLevel, description: memeLevel.speechBalloonText)
      levelTitleTextView
      LevelProgressView(level: .level1, conditionCount: 18)
      MemeLevelConditionView(conditionCount: 10)
      divider
      RecentlyMemeListView(memeDetailList: memeDetailList)
      myFarmemeListView
    }
  }
  
  var settingHeaderView: some View {
    HStack {
      Spacer()
      ResourceKitAsset.Icon.setting.swiftUIImage
        .frame(width: 20, height: 20, alignment: .center)
        .padding(.vertical, 15)
        .padding(.trailing, 20)
    }
  }
  
  var levelTitleTextView: some View {
    Text(memeLevel.levelTitleText)
      .font(Font.Family2.outLine)
      .padding(20)
  }
  
  var divider: some View {
    Rectangle()
      .frame(height: 10)
      .foregroundStyle(Color.Skeleton.secondary)
      .padding(.bottom, 20)
  }
  
  var myFarmemeListView: some View {
    VStack {
      ListHeaderView(icon: ResourceKitAsset.Icon.stroke.swiftUIImage,
                     title: "나의 파밈함")
      MemeListView(memeDetailList: memeDetailList)
        .padding(.horizontal, 20)
    }
  }
}


#Preview {
  MyPageView(memeLevel: .level1)
}
