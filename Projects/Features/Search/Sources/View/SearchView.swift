//
//  SearchView.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI

import PPACModels
import PPACData
import PPACNetwork
import PPACUtil
import DesignSystem
import ResourceKit

public struct SearchView: View {
  @ObservedObject var viewModel: SearchViewModel
  
  public init(viewModel: SearchViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      fakeSearchBar
      
      ScrollView {
        VStack(spacing: 0) {
          currentHotKeywords
          memeCategoriesViews
        }
      }
      .scrollIndicators(.hidden)
    }
    .padding(.bottom, 40)
    .onAppear {
      viewModel.dispatch(type: .viewWillAppear)
    }
    .basicModal(
      isPresented: $viewModel.state.isPresenting,
      opacity: 0.5,
      content: {
        SearchPreparingAlert {
          viewModel.dispatch(type: .dismissSearchBarAlert)
        }
      }
    )
  }
  
  private var fakeSearchBar: some View {
    Button {
      viewModel.dispatch(type: .searchBarTapped)
    } label: {
      FakeSearchBar(placeHolder: "🚧 검색은 오픈 준비 중!")
    }
    .buttonStyle(PlainButtonStyle())
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
      
      HorizontalMemeScrollView<HotKeyword, HotKeywordImageView>(items: $viewModel.state.hotKeywords) { hotKeyword in
        viewModel.dispatch(type: .hotKeywordTapped(keyword: hotKeyword.title))
      }
      .frame(height: 90)
    }
    .padding(.bottom, 40)
  }
  
  private var memeCategoriesViews: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(spacing: 8) {
        ResourceKitAsset.Icon.category.swiftUIImage
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 20, height: 20)
        
        Text("무슨 밈 찾아?")
          .font(Font.Heading.Small.semiBold)
          .foregroundColor(Color.Text.primary)
        
        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 18)
      
      ForEach(viewModel.state.memeCategories, id: \.self) { memeCategory in
        MemeCategoryView(
          category: memeCategory.category,
          keywords: memeCategory.keywords
        ) { keyword in
          viewModel.dispatch(type: .recommendKeywordTapped(keyword: keyword))
          viewModel.logSearch(event: .keyword, keyword: keyword, category: memeCategory.category)
        }
      }
    }
  }
}

extension HotKeyword: HorizontalMemeItemProtocol {}

