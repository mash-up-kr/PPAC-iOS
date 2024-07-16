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
import ResourceKit

public struct MainTabView: View {
  @ObservedObject private var viewModel: MainTabViewModel
  @State private var hotKeywords: [HotKeyword] = []
  @State public var mimCategories: [MimCategory] = []
  
  public init(viewModel: MainTabViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack {
      TabView(selection: $viewModel.state.selectedTab) {
        RecommendView()
          .tag(MainTab.recommend)
        SearchView(hotKeywords: hotKeywords, mimCategories: mimCategories)
          .tag(MainTab.search)
//        MyPageView(memeLevel: .level1, memeDetailList: [])
//          .tag(MainTab.mypage)
      }
      VStack {
        Spacer()
        CustomTabBarView(selectedTab: $viewModel.state.selectedTab)
          .shadow(color: Color.Border.tertiary, radius: 10, x: 0, y: 0)
      }
    }
    .edgesIgnoringSafeArea(.bottom)
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
  
  var tabImage: Image {
    return isSelected ? tab.selectedImage : tab.image
  }
  
  var color: SwiftUI.Color {
    return isSelected ? Color.Text.brand : Color.Text.assistive
  }
  
  var body: some View {
    VStack {
      tabImage
        .frame(width: 24, height: 24)
        .padding(.bottom, 2)
      
      Text(tab.title)
        .font(Font.Weight.semiBold)
    }
    .foregroundStyle(color)
    .padding(40)
  }
}


#Preview {
  MainTabView(viewModel: MainTabViewModel(router: MainTabRouter(UINavigationController(), userDetail: UserDetail.mock)))
}
