//
//  SavedMemeListView.swift
//  MyPage
//
//  Created by 장혜령 on 2024/07/15.
//

import SwiftUI
import DesignSystem
import ResourceKit
import PPACModels


struct SavedMemeListView: View {
  @State var memeDetailList: [MemeDetail]
  var body: some View {
    memeDetailList.count > 0
    ? memeListView
    : emptyView
  }
  
  var memeListView: some View {
    VStack {
      ListHeaderView(icon: ResourceKitAsset.Icon.stroke.swiftUIImage,
                     title: "나의 파밈함")
      MemeListView(memeDetailList: $viewModel.state.savedMemeList)
        .padding(.horizontal, 20)
    }
  }
  
  var emptyView: some View {
    MemeListEmptyView(description: "저장한 밈이 없어요")
  }
  
}
