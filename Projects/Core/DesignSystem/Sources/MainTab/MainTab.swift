//
//  MainTab.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/17/24.
//

import SwiftUI

import ResourceKit
import Lottie

public enum MainTab: String, CaseIterable, Identifiable {
  case recommend
  case search
  case mypage
  
  public var id: String { rawValue }
  
  public var image: Image {
    switch self {
    case .recommend:
      return ResourceKitAsset.Icon.recommendInactive.swiftUIImage
    case .search:
      return ResourceKitAsset.Icon.discoverInactive.swiftUIImage
    case .mypage:
      return ResourceKitAsset.Icon.myInactive.swiftUIImage
    }
  }
  
  public var selectedImage: Image {
    switch self {
    case .recommend:
      return ResourceKitAsset.Icon.recommendActive.swiftUIImage
    case .search:
      return ResourceKitAsset.Icon.discoverActive.swiftUIImage
    case .mypage:
      return ResourceKitAsset.Icon.myActive.swiftUIImage
    }
  }
  
  public var lottieAnimation: LottieAnimation? {
    switch self {
    case .recommend:
      AnimationAsset.tabRecommand.animation
    case .search:
      AnimationAsset.tabSearch.animation
    case .mypage:
      AnimationAsset.tabMy.animation
    }
  }
  
  public var title: String {
    switch self {
    case .recommend:
      return "추천"
    case .search:
      return "검색"
    case .mypage:
      return "마이"
    }
  }
  
}
