//
//  RecommendHeaderView.swift
//  Recommend
//
//  Created by 김종윤 on 6/29/24.
//

import SwiftUI
import ResourceKit

struct RecommendHeaderView: View {
  
  @Binding var userLevel: Int
  @Binding var seenMemeCount: Int
  @Binding var recommendMemeSize: Int
  
  public var body: some View {
    VStack(spacing: 0) {
      ResourceKitAsset.Icon.homeLogo.swiftUIImage
        .resizable()
        .frame(width: 212, height: 45, alignment: .center)
        .padding(.bottom, 10)
      
      recommendTitle
        .padding(.bottom, 16)
      
      recommendProgressBar(
        seenMemeCount: self.seenMemeCount,
        total: recommendMemeSize
      )
      .padding(.bottom, 8)
      
      recommendText(getRecommendText())
    }
  }
  
  private func getRecommendText() -> String {
    return if userLevel == 0 || seenMemeCount == 0 {
      "확인한 밈을 불러오지 못 했어요. 새로고침 해주세요"
    } else if userLevel == 1 &&
                (1...(recommendMemeSize - 1)).contains(seenMemeCount)
    {
      "밈 보고 레벨 포인트 받아요!"
    } else if userLevel == 2 && 
                (1...(recommendMemeSize - 1)).contains(seenMemeCount)
    {
      "추천 밈 둘러보세요!"
    } else {
      "완밈! 다음 주 밈도 기대해 주세요"
    }
  }
}

private var recommendTitle : some View {
  Text("이번 주 이 밈 어때!")
    .font(Font.Heading.Large.semiBold)
    .padding(.bottom, 8)
}

private func recommendProgressBar(
  seenMemeCount: Int,
  total: Int
) -> some View {
  HStack(spacing: 0) {
    ResourceKitAsset.Icon.squareCheck.swiftUIImage
    
    ProgressView(
      value: Double(seenMemeCount),
      total: Double(total)
    )
    .frame(width: 125, height: 8)
    .tint(Color.Icon.brand)
    .padding(.vertical, 4)
    .padding(.horizontal, 8)
    
    Text("\(seenMemeCount == 0 ? "?" : "\(seenMemeCount)")개 봤어요")
      .font(Font.Body.Small.semiBold)
      .foregroundColor(Color.Text.brand)
  }
}

private func recommendText(_ text: String) -> some View {
  Text(text)
    .font(Font.Body.Medium.medium)
    .foregroundStyle(Color.Text.secondary)
}

#Preview {
  @State var userLevel: Int = 1
  @State var seenMemeCount: Int = 5
  @State var recommendMemeSize: Int = 5
  
  return RecommendHeaderView(
    userLevel: $userLevel,
    seenMemeCount: $seenMemeCount,
    recommendMemeSize: $recommendMemeSize
  )
}
