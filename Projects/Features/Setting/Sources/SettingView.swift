//
//  SettingView.swift
//  Setting
//
//  Created by 장혜령 on 2024/07/21.
//

import SwiftUI
import ResourceKit
import DesignSystem

public struct SettingView: View {
  @ObservedObject private var viewModel: SettingViewModel
  
  @State private var tapType: SettingType?
  
  public init(viewModel: SettingViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    if let tapType {
      VStack {
        Divider()
          .padding(.top, 50)
    
        WebView(url: URL(string: tapType.url))
      }
      .plainNavigationBar(
        backHandler: {
          self.tapType = nil
        },
        rightActionHandler: nil,
        hasConfigureButton: false,
        title: tapType.title
      )
    } else {
      VStack{
        Divider()
          .padding(.top, 50)
    
        memeLogoImage
        appNameAndVersion
          .padding(.bottom, 50)
        
        Divider()
          .padding(.horizontal, 10)
          .padding(.bottom, 20)
        
        settingListView
        
        Spacer()
      }
      .plainNavigationBar(
        backHandler: {
          viewModel.dispatch(type: .naviBackButtonTapped)
        },
        rightActionHandler: nil,
        hasConfigureButton: false,
        title: "설정"
      )
    }
  }
  
  var memeLogoImage: some View {
    ResourceKitAsset.Icon.farmemeLogo.swiftUIImage
      .resizable()
      .frame(width: 70, height: 70, alignment: .center)
      .padding(.top, 50)
  }
  
  var appNameAndVersion: some View {
    VStack {
      Text("파밈")
        .font(Font.Heading.Medium.semiBold)
        .foregroundStyle(Color.Text.primary)
        .padding(.bottom, 2)
      Text(viewModel.state.currnetAppVersion)
        .font(Font.Body.Small.medium)
        .foregroundStyle(Color.Text.tertiary)
    }
  }
  
  var settingListView: some View {
    ForEach(viewModel.state.settingList) { settingType in
      SettingListItemView(
        type: settingType,
        tapType: $tapType
      )
    }
  }
}

struct SettingListItemView: View {
  let type: SettingType
  
  @Binding var tapType: SettingType?
  
  var body: some View {
    HStack {
      Text(type.title)
        .font(Font.Body.Xlarge.semiBold)
        .padding(.vertical, 20)
        .padding(.leading, 20)
      Spacer()
      ResourceKitAsset.Icon.arrowRight.swiftUIImage
        .resizable()
        .renderingMode(.template)
        .frame(width: 16, height: 16, alignment: .center)
        .foregroundStyle(Color.Icon.assistive)
        .padding(.trailing, 20)
        .onTapGesture {
          self.tapType = type
        }
    }
  }
}


#Preview {
  SettingView(viewModel: SettingViewModel(router: nil))
}
