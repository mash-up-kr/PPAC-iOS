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
  private let memeList: [MemeDetail] = Array(repeating: MemeDetail.mock, count: 10)
  
  public init(memeLevel: MemeLevelType) {
    self.memeLevel = memeLevel
  }
  
  public var body: some View {
    ScrollView {
      MyPageSettingHeaderView()
      MyPageCharacterView(description: memeLevel.speechBalloonText)
      LevelProgressView(level: 15)
      MemeLevelConditionView(conditionCount: 10)
      //recentlyMemeListView
      myFarmemeListView
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  var myFarmemeListView: some View {
    VStack {
      ListHeaderView(icon: ResourceKitAsset.Icon.stroke.swiftUIImage,
                     title: "나의 파밈함")
      MemeListView(memeList: memeList)
    }
    .padding(.horizontal, 20)
  }
  
  var recentlyMemeListView: some View {
    VStack {
      ListHeaderView(icon: ResourceKitAsset.Icon.stroke.swiftUIImage,
                     title: "최근 본 밈")
      MemeListView(memeList: memeList)
    }
  }
}


#Preview {
  MyPageView(memeLevel: .level1)
}
