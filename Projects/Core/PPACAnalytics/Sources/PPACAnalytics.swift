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
  
  public enum Action: String {
    case reaction
    case copy
    case share
    case save
    case saveCancel = "save_cancel"
    case tag
    case searchBar = "search_bar"
    case hotKeyword = "hot_keyword"
    case keyword
    case meme
    case settings
  }
  
  private init() {
    print("PPACAnalytics init")
  }
  
  public func congigureFirebaseApp() {
    FirebaseApp.configure()
  }
  
  public func click(
    action: Action,
    page: Page,
    memeId: String? = nil,
    memeTitle: String? = nil,
    extraParameters: [String: Any]? = nil
  ) {
    
    let keyName = "click_" + action.rawValue
    var parameters: [String: Any] = [:]
    parameters["page"] = page.rawValue
    
    if let memeId {
      parameters["meme_id"] = memeId
    }
    
    if let memeTitle {
      parameters["meme_title"] = memeTitle
    }
    
    if let extraParameters {
      parameters.merge(extraParameters) { (current, _) in current }
    }
    
    Analytics
      .logEvent(
        keyName,
        parameters: parameters
      )
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
