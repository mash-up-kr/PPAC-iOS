//
//  RecommendView.swift
//  Home
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI

public struct RecommendView: View {
  @EnvironmentObject private var coordinator: RecommendCoordinator
  
    public init() { }
    
  public var body: some View {
    VStack {
      Text("추천 화면")
        Button("밈 상세") {
            let _ = print("밈 상세 버튼 선택 ")
            //coordinator.fullScreenCover = .detailMim
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.yellow)
  }
}

#Preview {
  RecommendView()
}
