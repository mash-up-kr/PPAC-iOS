//
//  MemeDetailTabView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI
import ResourceKit

enum MemeDetailTab: CaseIterable, Identifiable {
  
  static var allCases: [MemeDetailTab] = [.copy, .share, .farmeme(on: false)]
  
  case copy
  case share
  case farmeme(on: Bool = false)
  
  var image: Image {
    switch self {
    case .copy:
      return ResourceKitAsset.Icon.copy.swiftUIImage
    case .share:
      return ResourceKitAsset.Icon.share.swiftUIImage
    case .farmeme(let isFarmemed):
      return isFarmemed ? ResourceKitAsset.Icon.filled.swiftUIImage : ResourceKitAsset.Icon.stroke.swiftUIImage
    }
  }
  
  var color: SwiftUI.Color {
    switch self {
    case .copy:
      return Color.Text.primary
    case .share:
      return Color.Text.primary
    case .farmeme(let on):
      return on ? Color.Text.brand : Color.Text.primary
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
  
  @Binding private var isFarmemed: Bool
  private var didTapDetailTab: ((MemeDetailTab) -> Void)?
  private var tabItems: [MemeDetailTab] {
    [.copy, .share, .farmeme(on: isFarmemed)]
  }
  
  init(
    isFarmemed: Binding<Bool>,
    didTapDetailTab: ( (MemeDetailTab) -> Void)? = nil
  ) {
    self._isFarmemed = isFarmemed
    self.didTapDetailTab = didTapDetailTab
  }
  
  var body: some View {
    VStack {
      HStack(alignment: .center) {
        ForEach(tabItems) { tab in
          Button {
            didTapDetailTab?(tab)
          } label: {
            TabItemView(tab: tab)
          }
          .buttonStyle(HighlightButtonStyle())
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
        .foregroundStyle(tab.color)
    }
  }
}


struct MemeDetailTabBarModifier: ViewModifier {
  let action: (MemeDetailTab) -> Void
  @Binding var isFarmemed: Bool
  
  func body(content: Content) -> some View {
    ZStack {
      content
      VStack {
        Spacer()
        MemeDetailTabBarView(isFarmemed: $isFarmemed) { tab in
          action(tab)
        }
      }
    }
  }
}

extension View {
  func memeDetailTabBar(
    isFarmemed: Binding<Bool>,
    action: @escaping (MemeDetailTab) -> Void
  ) -> some View {
    self.modifier(MemeDetailTabBarModifier(action: action, isFarmemed: isFarmemed))
  }
}

#Preview {
  @State var isFarmemed = true
  return VStack {
    Spacer()
    MemeDetailTabBarView(isFarmemed: $isFarmemed)
  }
  .background(.red)
}

struct HighlightButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(maxWidth: .infinity)
      .frame(height: 50)
      .background(configuration.isPressed ? Color.Skeleton.primary : Color.clear)
      .cornerRadius(8)
      .animation(nil, value: configuration.isPressed)
  }
}
