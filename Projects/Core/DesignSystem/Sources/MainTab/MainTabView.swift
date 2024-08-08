//
//  MainTabView.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI

import ResourceKit
import Lottie

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
    .frame(maxWidth: .infinity, maxHeight: 88)
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
  @State var playbackMode: LottiePlaybackMode = .paused(at: .progress(100))
  @State var isAnimationFinished: Bool = false
  
  var tabImage: Image {
    return isSelected ? tab.selectedImage : tab.image
  }
  
  var color: SwiftUI.Color {
    return isSelected ? Color.Text.brand : Color.Text.assistive
  }
  
  public var body: some View {
    VStack {
      tabImageView
      Text(tab.title)
        .font(Font.Weight.medium)
    }
    .foregroundStyle(color)
    .padding(40)
  }
  
  var tabImageView: some View {
    ZStack {
      if !isAnimationFinished && isSelected {
        LottieView(animation: tab.lottieAnimation)
          .playing()
          .animationDidFinish { _ in
            isAnimationFinished = true
          }
          .resizable()
          .frame(width: 24, height: 24)
      } else {
        tabImage
          .resizable()
          .frame(width: 24, height: 24)
          
      }
    }
    .padding(.bottom, 6)
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
