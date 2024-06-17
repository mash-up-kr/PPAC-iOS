//
//  MyPageView.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI

public struct MyPageView: View {
  public init() { }
  
  public var body: some View {
    Text("마이페이지 화면")
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.blue)
  }
}

#Preview {
  MyPageView()
}
