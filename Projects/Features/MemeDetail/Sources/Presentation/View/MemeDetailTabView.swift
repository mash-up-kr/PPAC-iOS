//
//  MemeDetailTabView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI

import ResourceKit

enum MemeDetailTab: CaseIterable, Identifiable {
  case copy
  case share
  case farmeme
  
  var image: Image {
    switch self {
    case .copy:
      return ResourceKitAsset.Icon.copy.swiftUIImage
    case .share:
      return ResourceKitAsset.Icon.share.swiftUIImage
    case .farmeme:
      return ResourceKitAsset.Icon.stroke.swiftUIImage
    }
  }
  
  var title: String {
    switch self {
    case .copy:
      return "복사"
    case .share:
      return "공유"
    case .farmeme:
      return "파밈"
    }
  }
  
  var id: String {
    self.title
  }
}

struct MemeDetailTabBarView: View {
  
  private var didTapDetailTab: ((MemeDetailTab) -> Void)?
  
  init(didTapDetailTab: ( (MemeDetailTab) -> Void)? = nil) {
    self.didTapDetailTab = didTapDetailTab
  }
  
  var body: some View {
    VStack {
      HStack(alignment: .center) {
        ForEach(MemeDetailTab.allCases) { tab in
          TabItemView(tab: tab)
            .frame(maxWidth: .infinity)
            .onTapGesture {
              didTapDetailTab?(tab)
            }
        }
      }
      .frame(height: 50)
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
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
  
  let tab: MemeDetailTab
  
  var body: some View {
    HStack(spacing: 4) {
      tab.image
        .resizable()
        .frame(width: 20, height: 20)
      
      Text(tab.title)
        .font(Font.Body.Xlarge.semiBold)
        .foregroundStyle(Color.Text.primary)
    }
  }
}


struct MemeDetailTabBarModifier: ViewModifier {
    let action: (MemeDetailTab) -> Void
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                Spacer()
                MemeDetailTabBarView { tab in
                    action(tab)
                }
            }
        }
    }
}

extension View {
    func memeDetailTabBar(action: @escaping (MemeDetailTab) -> Void) -> some View {
        self.modifier(MemeDetailTabBarModifier(action: action))
    }
}

#Preview {
  VStack {
    Spacer()
    MemeDetailTabBarView()
  }
  .background(.red)
}
