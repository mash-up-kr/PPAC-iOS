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

import SkeletonUI

public struct SearchView: View {
  @Environment(\.screenSize) var screenSize
  @ObservedObject var viewModel: SearchViewModel
  
  public init(viewModel: SearchViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack {
      VStack(spacing: 0) {
        fakeSearchBar
        
        ScrollView {
          VStack(spacing: 0) {
            currentHotKeywords
            memeCategoriesViews
          }
          
          Spacer()
            .frame(height: 64 + 50)
        }
        .scrollIndicators(.hidden)
      }
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
      
      if viewModel.state.isLoading {
        skeletonView
      }
    }
    .animation(.easeInOut, value: viewModel.state.isLoading)
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
  
  private var skeletonView: some View {
    VStack(alignment: .leading, spacing: 0) {
      EmptyView()
      searchSkeleton(
        size: .init(width: screenSize.width - 40, height: 44),
        shape: .rounded(.radius(10))
      )
      .padding(.vertical, 16)
      
      searchSkeleton(
        size: .init(width: 200, height: 20),
        shape: .rounded(.radius(4))
      )
      .padding(.vertical, 18)
      
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          ForEach(0..<5) { _ in
            searchSkeleton(
              size: .init(width: 90, height: 92),
              shape: .rounded(.radius(12))
            )
          }
          Spacer()
        }
      }
      .padding(.bottom, 40)
      
      searchSkeleton(
        size: .init(width: 200, height: 20),
        shape: .rounded(.radius(4))
      )
      .padding(.vertical, 18)
      
      searchSkeleton(
        size: .init(width: 60, height: 16),
        shape: .rounded(.radius(4))
      )
      .padding(.top, 4)
      .padding(.bottom, 16)
      
      HStack {
        ForEach(0..<3) { _ in
          searchSkeleton(
            size: .init(width: 60, height: 36),
            shape: .rounded(.radius(18))
          )
          .padding(.top, 4)
        }
      }
      
      Spacer()
    }
    .padding(.leading, 20)
    .background(.white)
  }
  
  private func searchSkeleton(size: CGSize? = .none, shape: ShapeType = .capsule) -> some View {
    EmptyView()
      .skeleton(
        with: viewModel.state.isLoading,
        size: size,
        animation: .linear(duration: 2, delay: 0, speed: 1),
        appearance: .gradient(
          .linear,
          color: Color.Skeleton.secondary,
          background: Color.Skeleton.primary,
          radius: 1
        ),
        shape: shape
      )
  }
}

extension HotKeyword: HorizontalMemeItemProtocol {}
