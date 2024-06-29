//
//  MemeListView.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import PPACModels

public struct MemeListView: View {

  private let memeList: [MemeDetail]
  private let columns = Array(repeating: GridItem(.adaptive(minimum: 100, maximum: 300),
                                          spacing: 12,
                                          alignment: .center),count: 2)
  
  public init(memeList: [MemeDetail]) {
    self.memeList = memeList
  }
  
  public var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(0..<memeList.count, id: \.self) { index in
          let memeDetail = memeList[index]
          MemeItemView(memeDetail: memeDetail)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
        }
      }
    }
  }
}

#Preview {
  MemeListView(memeList: [MemeDetail.mock, MemeDetail.mock, MemeDetail.mock, MemeDetail.mock, MemeDetail.mock])
}
