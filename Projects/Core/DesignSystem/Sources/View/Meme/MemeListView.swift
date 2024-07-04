//
//  MemeListView.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import PPACModels

public struct MemeListView: View {

  private let memeDetailList: [MemeDetail]
  private let columns = Array(repeating: GridItem(.adaptive(minimum: 100, maximum: 300),
                                          spacing: 12,
                                          alignment: .center),count: 2)
  
  public init(memeDetailList: [MemeDetail]) {
    self.memeDetailList = memeDetailList
  }
  
  public var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
//        ForEach(0..<memeDetailList.count, id: \.self) { index in
//          let memeDetail = memeDetailList[index]
//          MemeItemView(memeDetail: memeDetail)
//            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
//        }
        ForEach(memeDetailList) { memeDetail in
          MemeItemView(memeDetail: memeDetail)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
        }
      }
    }
  }
}

#Preview {
  let memeDetailList = Array(repeating: MemeDetail.mock, count: 10)
  return MemeListView(memeDetailList: memeDetailList)
}
