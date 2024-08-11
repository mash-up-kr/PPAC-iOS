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
    HStack(spacing: 8) {
      icon
        .resizable()
        .frame(width: 20, height: 20, alignment: .center)
      Text(title)
        .font(Font.Heading.Small.semiBold)
      Spacer()
    }
    .padding(.vertical, 18)
    .padding(.horizontal, 20)
  }
}

#Preview {
  ListHeaderView(icon: ResourceKitAsset.Icon.successStoke.swiftUIImage, title: "나의 파밈")
}
