//
//  RecentlyMemeListView.swift
//  MyPage
//
//  Created by 장혜령 on 7/2/24.
//

import SwiftUI
import DesignSystem
import ResourceKit
import PPACModels
import Kingfisher

struct RecentlyMemeListView: View {
  @State var memeDetailList: [MemeDetail]
  var body: some View {
    VStack {
      ListHeaderView(icon: ResourceKitAsset.Icon.check.swiftUIImage,
                     title: "최근 본 밈")
      if memeDetailList.count > 0 {
        memeListView
      } else {
        emptyView
      }
    }
  }
  
  
  var memeListView: some View {
    VStack {
      HorizontalMimScrollView<MemeDetail, MemeSimpleItemView>(items: $memeDetailList)
        .frame(height: 120)
    }
    .padding(.bottom, 50)
  }
  
  var emptyView: some View {
    MemeListEmptyView(description: "최근 본 밈이 없어요")
  }
  
}

extension MemeDetail: HorizontalMimItemProtocol {}

struct MemeSimpleItemView: View, HorizontalMimItemViewProtocol {
  typealias Item = MemeDetail
  let memeDetail: MemeDetail
  
  init(item memeDetail: MemeDetail) {
    self.memeDetail = memeDetail
  }
  
  var body: some View {
    MemeImageView(imageUrlString: memeDetail.imageUrlString)
      .frame(width: 120, height: 120, alignment: .center)
  }
}

#Preview {
  let memeDetailList: [MemeDetail] = Array(repeating: MemeDetail.mock, count: 10)
  return RecentlyMemeListView(memeDetailList: memeDetailList)
}
