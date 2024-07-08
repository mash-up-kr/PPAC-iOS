//
//  MainTabView.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI
import Recommend
import Search
import MyPage
import PPACData
import PPACModels
import PPACNetwork

public struct MainTabView: View {
  @State private var selectedTab: MainTab = .recommend
  @State private var hotKeywords: [HotKeyword] = []
  @State public var mimCategories: [MimCategory] = []
  
  public init() {}
  
  public var body: some View {
    ZStack {
      TabView(selection: $selectedTab) {
        RecommendView()
          .tag(MainTab.recommend)
        SearchView(hotKeywords: hotKeywords, mimCategories: mimCategories)
          .tag(MainTab.search)
        MyPageView()
          .tag(MainTab.mypage)
      }
      VStack {
        Spacer()
        CustomTabBarView(selectedTab: $selectedTab)
      }
    }
    .edgesIgnoringSafeArea(.bottom)
    .onAppear {
      Task {
        let repository = KeywordRepositoryImpl(networkService: NetworkService())
        do {
          hotKeywords = try await repository.getHotKeywords()
          mimCategories = try await repository.getMimCategorys()
          print("hotKeywords = \(hotKeywords)")
          print("mimCategories = \(mimCategories)")
        } catch(let error) {
          print("error = \(error )")
        }
      }
    }
  }
}

struct CustomTabBarView: View {
  @Binding var selectedTab: MainTab
  
  var body: some View {
    VStack {
      HStack {
        ForEach(MainTab.allCases) { tab in
          TabItemView(tab: tab, isSelected: selectedTab == tab)
            .onTapGesture {
              selectedTab = tab
            }
        }
      }
      Spacer(minLength: 20)
    }
    .frame(maxWidth: .infinity, maxHeight: 98)
    .background(.white)
    .clipShape(
      .rect(
        topLeadingRadius: 30,
        topTrailingRadius: 30
      )
    )
  }
}


struct TabItemView: View {
  
  let tab: MainTab
  let isSelected: Bool
  
  var body: some View {
    VStack {
      Image(systemName: isSelected ? tab.selectedImage : tab.image)
        .frame(width: 20, height: 20)
      Text(tab.title)
        .font(.system(size: 11))
    }
    .padding(40)
  }
}


#Preview {
  MainTabView()
}
