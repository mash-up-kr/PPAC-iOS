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
  private let columns = Array(repeating: GridItem(.flexible(),
                                          spacing: 12,
                                          alignment: .center),count: 2)
  
  public init(memeDetailList: [MemeDetail]) {
    self.memeDetailList = memeDetailList
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
      HStack {
        LazyVStack {
          ForEach(oddIndexedItems) { memeDetail in
            MemeItemView(memeDetail: memeDetail)
          }
        }
        
        LazyVStack {
          ForEach(evenIndexedItems) { memeDetail in
            MemeItemView(memeDetail: memeDetail)
          }
        }
      }
      .frame(maxWidth: .infinity) 
    }
    .scrollTargetBehavior(.viewAligned)
  }
}

#Preview {
  let mockImageList = ["https://plus.unsplash.com/premium_photo-1661892088256-0a17130b3d0d?q=80&w=3560&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                       "https://plus.unsplash.com/premium_photo-1676955432796-226f504a560b?q=80&w=3333&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1720247521923-f531207d23d8?q=80&w=2667&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
             
                       "https://images.unsplash.com/photo-1507146426996-ef05306b995a?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" ]
  
  let memeDetailList = (0..<20)
    .map { MemeDetail(id: "\($0)", title: MemeDetail.mock.title,
                      keywords: MemeDetail.mock.keywords,
                      imageUrlString: mockImageList[$0 % 4],
                      source: MemeDetail.mock.source,
                      isTodayMeme: true, reaction: $0 % 4) }
  return MemeListView(memeDetailList: memeDetailList)
}
