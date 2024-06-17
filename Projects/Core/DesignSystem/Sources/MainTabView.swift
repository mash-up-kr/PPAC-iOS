//
//  MainTabView.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI

enum MainTab: String, CaseIterable, Identifiable {
  case recommend
  case search
  case mypage
  
  var id: String { rawValue }
  
  var image: String {
    switch self {
    case .recommend:
      return "1.square.fill"
    case .search:
      return "2.square.fill"
    case .mypage:
      return "3.square.fill"
    }
  }
  
  var selectedImage: String {
    switch self {
    case .recommend:
      return "1.square"
    case .search:
      return "2.square"
    case .mypage:
      return "3.square"
    }
  }
  
  var title: String {
    switch self {
    case .recommend:
      return "추천"
    case .search:
      return "검색"
    case .mypage:
      return "마이"
    }
  }
  
  var tabView: AnyView {
    switch self {
    case .recommend:
      return AnyView(RecommendView())
    case .search:
      return AnyView(SearchView())
    case .mypage:
      return AnyView(MyPageView())
    }
  }
}

public struct MainTabView: View {
  @State private var selectedTab: MainTab = .recommend
  
  public init() {}
  
  public var body: some View {
    ZStack {
      VStack {
        TabView(selection: $selectedTab) {
          ForEach(MainTab.allCases) { tab in
            VStack {
              tab.tabView
            }
            .tag(tab)
          }
        }
      }
      CustomTabBar(selectedTab: $selectedTab)
    }
    .edgesIgnoringSafeArea(.bottom)
  }
}


struct CustomTabBar: View {
  @Binding var selectedTab: MainTab
  
  var body: some View {
    VStack {
      Spacer()
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
      .background(Color.white)
      .cornerRadius(30, corners: [.topLeft, .topRight])
    }
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
