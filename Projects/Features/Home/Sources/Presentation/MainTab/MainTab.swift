//
//  MainTab.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/17/24.
//

import SwiftUI
import ResourceKit

enum MainTab: String, CaseIterable, Identifiable {
  case recommend
  case search
  case mypage
  
  var id: String { rawValue }
  
  var image: Image {
    switch self {
    case .recommend:
      return ResourceKitAsset.Icon.recommendInactive.swiftUIImage
    case .search:
      return ResourceKitAsset.Icon.discoverInactive.swiftUIImage
    case .mypage:
      return ResourceKitAsset.Icon.myInactive.swiftUIImage
    }
  }
  
  var uiImage: UIImage {
    switch self {
    case .recommend:
      return ResourceKitAsset.Icon.recommendInactive.image
    case .search:
      return ResourceKitAsset.Icon.discoverInactive.image
    case .mypage:
      return ResourceKitAsset.Icon.myInactive.image
    }
  }
  
  var selectedImage: Image {
    switch self {
    case .recommend:
      return ResourceKitAsset.Icon.recommendActive.swiftUIImage
    case .search:
      return ResourceKitAsset.Icon.discoverActive.swiftUIImage
    case .mypage:
      return ResourceKitAsset.Icon.myActive.swiftUIImage
    }
  }
  
  var selectedUIImage: UIImage {
    switch self {
    case .recommend:
      return ResourceKitAsset.Icon.recommendActive.image
    case .search:
      return ResourceKitAsset.Icon.discoverActive.image
    case .mypage:
      return ResourceKitAsset.Icon.myActive.image
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
  
}
