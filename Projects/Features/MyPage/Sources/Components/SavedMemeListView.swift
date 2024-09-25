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
  @Binding var memeDetailList: [MemeDetail]
  var memeClickHandler: ((MemeDetail) -> ())?
  var memeCopyHandler: ((MemeDetail) -> ())?
  var onAppearLastMemeHandler: (() -> ())?
  
  var body: some View {
    VStack {
      if memeDetailList.count > 0 {
        memeListView
      } else {
        emptyView
      }
    }
  }
  
  var memeListView: some View {
    VStack {
      MemeListView(
        memeDetailList: $memeDetailList,
        memeClickHandler: memeClickHandler,
        memeCopyHandler: memeCopyHandler,
        onAppearLastMemeHandler: onAppearLastMemeHandler
      )
      .padding(.horizontal, 20)
    }
  }
  
  var emptyView: some View {
    MemeListEmptyView(description: "저장한 밈이 없어요")
  }
  
}
