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
      MyPageCharacterView(description: memeLevel.speechBalloonText)
      LevelProgressView(level: 15)
      MemeLevelConditionView(conditionCount: 10)
      RecentlyMemeListView(memeDetailList: memeDetailList)
      myFarmemeListView
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  var settingHeaderView: some View {
    HStack {
      Spacer()
      ResourceKitAsset.Icon.setting.swiftUIImage
        .frame(width: 20, height: 20, alignment: .center)
        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 20))
    }
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
