//
//  ListHeaderView.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit

public struct ListHeaderView: View {
  private var icon: Image
  private var title: String
  
  public init(icon: Image, title: String) {
    self.icon = icon
    self.title = title
  }
  
  public var body: some View {
    HStack {
      icon
        .resizable()
        .frame(width: 20, height: 20, alignment: .center)
        .padding(.leading, 20)
      Text(title)
        .font(Font.Heading.Small.semiBold)
      Spacer()
    }
  }
}

#Preview {
  ListHeaderView(icon: ResourceKitAsset.Icon.successStoke.swiftUIImage, title: "나의 파밈")
}
