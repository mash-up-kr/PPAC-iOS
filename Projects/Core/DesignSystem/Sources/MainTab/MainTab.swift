//
//  MainTab.swift
//  DesignSystem
//
//  Created by 장혜령 on 6/17/24.
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
