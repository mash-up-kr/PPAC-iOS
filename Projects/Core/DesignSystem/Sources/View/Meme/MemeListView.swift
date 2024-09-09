//
//  MemeListView.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import PPACModels

public struct MemeListView: View {

  @Binding var memeDetailList: [MemeDetail]
  private let memeClickHandler: ((MemeDetail) -> ())?
  private let memeCopyHandler: ((MemeDetail) -> ())?
  private let onAppearLastMemeHandler: (() -> ())?
  private var lastMemeId: String {
    return memeDetailList.last?.id ?? ""
  }
  
  public init(
    memeDetailList: Binding<[MemeDetail]>,
    memeClickHandler: ((MemeDetail) -> ())? = nil,
    memeCopyHandler: ((MemeDetail) -> ())? = nil,
    onAppearLastMemeHandler: (() -> ())? = nil
  ) {
    self._memeDetailList = memeDetailList
    self.memeClickHandler = memeClickHandler
    self.memeCopyHandler = memeCopyHandler
    self.onAppearLastMemeHandler = onAppearLastMemeHandler
  }
  
  var oddIndexedItems: [MemeDetail] {
    memeDetailList.enumerated().compactMap { index, element in
      return index % 2 == 0 ? element : nil
    }
  }
  
  var evenIndexedItems: [MemeDetail] {
    memeDetailList.enumerated().compactMap { index, element in
      return index % 2 != 0 ? element : nil
    }
  }
  
  public var body: some View {
    ScrollView {
      HStack(alignment: .top) {
        LazyVStack(spacing: 20) {
          ForEach(oddIndexedItems) { memeDetail in
            MemeItemView(
              memeDetail: memeDetail,
              memeClickHandler: memeClickHandler,
              memeCopyHandler: memeCopyHandler
            )
          }
        }
        
        LazyVStack(spacing: 20) {
          ForEach(evenIndexedItems) { memeDetail in
            MemeItemView(
              memeDetail: memeDetail,
              memeClickHandler: memeClickHandler,
              memeCopyHandler: memeCopyHandler
            )
          }
        }
      }
      .background(
        GeometryReader { geometry in
          Color.clear.frame(height: 1)
          Color.clear
            .preference(
              key: ScrollContentHeight.self,
              value: geometry.size.height
            )
          Color.clear
            .preference(
              key: ScrollOffsetKey.self,
              value: geometry.frame(in: .global).origin.y
            )
        }
      )
      
      .onChange(of: memeDetailList, initial: false) { oldList, newList in
        isLoadCompleted = true
        // refresh되면서 newList가 oldList보다 작아진 순간에만 호출되도록
        guard newList.count < oldList.count else { return }
        if newList.contains(where: { $0.id == lastMemeId }) {
          onAppearLastMemeHandler?()
        }
      }
    }
    .frame(maxWidth: .infinity)
    .onPreferenceChange(ScrollOffsetKey.self) { value in
      scrollOffset = value
      checkIfNeedToLoadMore()
    }
    .onPreferenceChange(ScrollContentHeight.self) { value in
      scrollContentHeight = value
      checkIfNeedToLoadMore()
    }
  }
  
  // MARK: - 페이징 API 호출 체크
  @Environment(\.screenSize) var screenSize
  @State private var scrollContentHeight: CGFloat = 0
  @State private var scrollOffset: CGFloat = 0
  @State private var isLoadCompleted: Bool = true
  private let threshold: CGFloat = 400 // 남은 스크롤 영역
  
  private func checkIfNeedToLoadMore() {
    guard isLoadCompleted else { return }
    let result = scrollContentHeight - screenSize.height + scrollOffset
    if result > 0, result < threshold {
      onAppearLastMemeHandler?()
      isLoadCompleted = false
    }
  }
  
  struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
      value += nextValue()
    }
  }
  
  struct ScrollContentHeight: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
      value += nextValue()
    }
  }
  
}


#Preview {
  let mockImageList = ["https://plus.unsplash.com/premium_photo-1661892088256-0a17130b3d0d?q=80&w=3560&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                       "https://plus.unsplash.com/premium_photo-1676955432796-226f504a560b?q=80&w=3333&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                       "https://images.unsplash.com/photo-1720247521923-f531207d23d8?q=80&w=2667&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                       
                       "https://images.unsplash.com/photo-1507146426996-ef05306b995a?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
  
  @State var memeDetailList = (0..<20)
    .map { MemeDetail(id: "\($0)", title: MemeDetail.mock.title,
                      keywords: MemeDetail.mock.keywords,
                      imageUrlString: mockImageList[$0 % 4],
                      source: MemeDetail.mock.source,
                      isTodayMeme: true, reaction: $0 % 4, isFarmemed: true, isReaction: false) }
  return MemeListView(memeDetailList: $memeDetailList)
}
