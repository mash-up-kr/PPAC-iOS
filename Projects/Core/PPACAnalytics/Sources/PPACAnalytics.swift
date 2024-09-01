//
//  PPACAnalytics.swift
//  PPACAnalytics
//
//  Created by 장혜령 on 9/2/24.
//

import Foundation

import FirebaseCore
import FirebaseAnalytics

final public class PPACAnalytics {
  static public let shared = PPACAnalytics()
  
  public enum Page: String {
    case recommend
    case memeDetail = "meme_detail"
    case search
    case searchDetail = "search_detail"
    case myPage = "my_page"
    case settings
  }
  
  private init() {
    print("PPACAnalytics init")
  }
  
  public func congigureFirebaseApp() {
    FirebaseApp.configure()
  }
  
  public func clickCopy (
    page: Page,
    memeId: String,
    memeTitle: String
  ) {
    Analytics
      .logEvent(
        "click_copy",
        parameters: [
          "page": page.rawValue,
          "meme_id" : memeId,
          "meme_title": memeTitle
        ]
      )
  }
  
}
