//
//  RecommendHeaderView.swift
//  Recommend
//
//  Created by 김종윤 on 6/29/24.
//

import SwiftUI
import ResourceKit

struct RecommendHeaderView: View {
  
  public var body: some View {
    VStack {
      ResourceKitAsset.Icon.homeLogo.swiftUIImage
        .padding(.bottom, 10)
      
      recommendTitle
      
      recommendProgressBar(numOfSaw: 1, total: 5)
      
      recommendText("밈 보고 레벨 포인트를 받아요!")
    }
  }
}

var recommendTitle : some View {
  Text("이번주 이 밈 어때!")
    .font(Font.Heading.large)
    .padding(.bottom, 8)
}

func recommendProgressBar(
  numOfSaw: Int,
  total: Int
) -> some View {
  HStack {
    ResourceKitAsset.Icon.squareCheck.swiftUIImage
    
    ProgressView(value: Double(numOfSaw), total: Double(total))
      .frame(width: 125, height: 8)
      .tint(Color.Icon.brand)
      .padding(.vertical, 4)
      .padding(.horizontal, 8)
    
    Text("\(numOfSaw)개 봤어요")
      .font(Font.Body.small)
      .foregroundColor(Color.Text.brand)
  }
}

func recommendText(_ text: String) -> some View {
  Text(text)
    .font(Font.Weight.semiBold)
    .foregroundStyle(Color.Text.secondary)
}
