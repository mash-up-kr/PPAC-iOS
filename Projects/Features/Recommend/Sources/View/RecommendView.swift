//
//  RecommendView.swift
//  Home
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI

public struct RecommendView: View {
  public init() { }
  
  public var body: some View {
    VStack {
      Text("추천 화면")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.yellow)
  }
}

#Preview {
  RecommendView()
}
