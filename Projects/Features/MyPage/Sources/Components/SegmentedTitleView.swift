//
//  SegmentedTitleView.swift
//  MyPage
//
//  Created by 장혜령 on 9/25/24.
//

import SwiftUI

import ResourceKit

struct SegmentedTitleItem: Hashable, Identifiable {
  let id = UUID()
  let title: String
  let isSelected: Bool
}

struct SegmentedTitleView: View {
  
  let titleItems: [SegmentedTitleItem]
  let titleItemClickHandler: ((String) -> ())?
  
  init(titleItems: [SegmentedTitleItem], titleItemClickHandler: ((String) -> ())? = nil) {
    self.titleItems = titleItems
    self.titleItemClickHandler = titleItemClickHandler
  }
  
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        ForEach(titleItems, id: \.self) { item in
          SegmentedItemView(item: item)
            .onTapGesture {
              // 선택되지 않은 title item을 선택했을 때만 업데이트 진행
              guard !item.isSelected else { return }
              titleItemClickHandler?(item.title)
            }
        }
      }
      .padding(.horizontal, 20)
      Rectangle()
        .frame(height: 1)
        .foregroundStyle(Color.Border.tertiary)
    }
    .padding(.bottom, 20)
  }
}

struct SegmentedItemView: View {
  
  let item: SegmentedTitleItem
 
  var body: some View {
    VStack(spacing: 15) {
      Text(item.title)
        .font(Font.Body.Xlarge.semiBold)
        .foregroundStyle(item.isSelected ? Color.Text.primary : Color.Text.tertiary)
      Rectangle()
        .foregroundStyle(item.isSelected ? Color.Background.primary : Color.clear)
        .frame(height: 2)
    }
  }
}

#Preview {
  let segmentedItems = [SegmentedTitleItem(title: "나의 파밈함", isSelected: true),
                        SegmentedTitleItem(title: "나의 밈", isSelected: false)]
  return SegmentedTitleView(titleItems: segmentedItems)
}
