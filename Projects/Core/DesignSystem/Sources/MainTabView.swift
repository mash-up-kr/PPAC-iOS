//
//  MainTabView.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI

enum Tab: String, CaseIterable, Identifiable {
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
  @State private var selectedTab: Tab = .recommend
  
  public init() {}
  
  public var body: some View {
    ZStack {
      VStack {
        TabView(selection: $selectedTab) {
          ForEach(Tab.allCases) { tab in
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
  @Binding var selectedTab: Tab
  
  var body: some View {
    VStack {
      Spacer()
      VStack {
        HStack {
          ForEach(Tab.allCases) { tab in
            TabItemView(image: tab.image,
                        selectedImage: tab.image,
                        tabTitle: tab.title)
            .onTapGesture {
              selectedTab = tab
            }
          }
        }
        Spacer(minLength: 20)
      }
      .frame(maxWidth: .infinity, maxHeight: 98)
      .background(Color.gray.opacity(0.3))
      .cornerRadius(30, corners: [.topLeft, .topRight])
    }
  }
}

struct TabItemView: View {
  
  let image: String
  let selectedImage: String
  let tabTitle: String
  
  var body: some View {
    VStack {
      Image(systemName: image)
        .frame(width: 20, height: 20)
      Text(tabTitle)
        .font(.system(size: 11))
    }
    .padding(40)
  }
}



#Preview {
  MainTabView()
}
