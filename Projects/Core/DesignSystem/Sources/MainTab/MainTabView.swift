//
//  MainTabView.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI
import ResourceKit

public struct CustomTabBarView: View {
  @Binding public var selectedTab: MainTab
  
  public var body: some View {
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


public struct TabItemView: View {
  
  let tab: MainTab
  let isSelected: Bool
  
  var tabImage: Image {
    return isSelected ? tab.selectedImage : tab.image
  }
  
  var color: SwiftUI.Color {
    return isSelected ? Color.Text.brand : Color.Text.assistive
  }
  
  public var body: some View {
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

struct TabBarModifier: ViewModifier {
    @Binding var selectedTab: MainTab
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                CustomTabBarView(selectedTab: $selectedTab)
                    .shadow(color: Color.Border.tertiary, radius: 10, x: 0, y: 0)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

public extension View {
    public func tabBar(selectedTab: Binding<MainTab>) -> some View {
        self.modifier(TabBarModifier(selectedTab: selectedTab))
    }
}
