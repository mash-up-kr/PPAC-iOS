//
//  SearchView.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI
import PPACModels
import ResourceKit
import DesignSystem

public struct SearchView: View {
  @State public var hotKeywords: [HotKeyword]
  @State public var mimCategories: [MimCategory]
  @State private var isPresenting: Bool = false
  
  public init(hotKeywords: [HotKeyword] = [], mimCategories: [MimCategory] = []) {
    self.hotKeywords = hotKeywords
    self.mimCategories = mimCategories
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      Button {
        isPresenting = true
      } label: {
        FakeSearchBar(placeHolder: "🚧 검색은 오픈 준비 중!")
      }
      .buttonStyle(PlainButtonStyle())
      
      ScrollView {
        VStack(spacing: 0) {
          currentHotKeywords
          mimCategoriesViews
        }
      }
      .scrollIndicators(.hidden)
    }
    .padding(.bottom, 40)
    .basicModal(
      isPresented: $isPresenting,
      opacity: 0.5,
      content: {
        SearchPreparingAlert(dismiss: { isPresenting = false })
      }
    )
  }
  
  private var currentHotKeywords: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(spacing: 8) {
        ResourceKitAsset.Icon.special.swiftUIImage
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 20, height: 20)
        
        Text("두둥! 요즘 핫한 #키워드")
          .font(Font.Heading.Small.semiBold)
          .foregroundColor(Color.Text.primary)
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 18)
      
      HorizontalMimScrollView<HotKeyword, HotKeywordImageView>(items: $hotKeywords)
    }
    .padding(.bottom, 40)
  }

  private var mimCategoriesViews: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(spacing: 8) {
        ResourceKitAsset.Icon.category.swiftUIImage
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 20, height: 20)
        
        Text("무슨 밈 찾아?")
          .font(Font.Heading.Small.semiBold)
          .foregroundColor(Color.Text.primary)
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 18)
      
      ForEach(mimCategories, id: \.self) { mimCategory in
        MimCategoryView(title: mimCategory.title, categories: mimCategory.categories)
      }
    }
  }
}

extension HotKeyword: HorizontalMimItemProtocol {}

#Preview {
  SearchView(
    hotKeywords: [
      .mock1,
      .mock2,
      .mock3,
      .mock4
    ], mimCategories: [
      .mock1,
      .mock2,
      .mock3
    ]
  )
}
