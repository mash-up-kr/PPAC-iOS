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
  @Binding var memeDetailList: [MemeDetail]
  var memeClickHandler: ((MemeDetail) -> ())?
  
  var body: some View {
    VStack {
      ListHeaderView(icon: ResourceKitAsset.Icon.successStoke.swiftUIImage,
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
      HorizontalMemeScrollView<MemeDetail, MemeSimpleItemView>(
        items: $memeDetailList,
        itemClickHandler: memeClickHandler
      )
      .frame(height: 120)
    }
    .padding(.bottom, 50)
  }
  
  var emptyView: some View {
    MemeListEmptyView(description: "최근 본 밈이 없어요")
  }
}

extension MemeDetail: HorizontalMemeItemProtocol {}

struct MemeSimpleItemView: View, HorizontalMemeItemViewProtocol {
  typealias Item = MemeDetail
  let memeDetail: MemeDetail
  @State private var isImageLoaded: Bool = false
  
  init(item memeDetail: MemeDetail) {
    self.memeDetail = memeDetail
  }
  
  public var body: some View {
    ZStack {
      KFImage(URL(string: memeDetail.imageUrlString))
        .resizable()
        .loadDiskFileSynchronously()
        .cacheMemoryOnly()
        .onSuccess { _ in
          isImageLoaded = true
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: 120, height: 120, alignment: .center)
        .cornerRadius(12)
        .opacity(isImageLoaded ? 1 : 0) // 이미지 로드 완료 전에 투명하게 처리
      
      if !isImageLoaded {
        skeletonView
      }
    }
  }
  
  var skeletonView: some View {
    EmptyView()
      .skeleton(
        with: !isImageLoaded,
        animation: .linear(duration: 2, delay: 0, speed: 1),
        appearance: .gradient(
          .linear,
          color: Color.Skeleton.secondary,
          background: Color.Skeleton.primary,
          radius: 1
        ),
        shape: .rounded(.radius(12))
      )
      .frame(width: 120, height: 120, alignment: .center)
  }

}

//#Preview {
//  @State var memeDetailList: [MemeDetail] = Array(repeating: MemeDetail.mock, count: 10)
//  return RecentlyMemeListView(memeDetailList: memeDetailList)
//}
