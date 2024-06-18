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
      .clipShape(
        .rect(
          topLeadingRadius: 30,
          topTrailingRadius: 30
        )
      )
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
