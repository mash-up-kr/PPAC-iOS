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
  
  public enum UserInteraction: String {
    case click
    case view
    case swipe
    case scroll
  }
  
  public enum Page: String {
    case recommend
    case memeDetail = "meme_detail"
    case search
    case searchDetail = "search_detail"
    case myPage = "my_page"
    case settings
  }
  
  public enum UserEvent: String {
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
    case appUpdate = "app_update"
  }
  
  private init() {
    print("PPACAnalytics init")
  }
  
  public func congigureFirebaseApp() {
    FirebaseApp.configure()
  }
  
  public func setUserID(_ id: String) {
    Analytics.setUserID(id)
  }
  
  public func log(
    interaction: UserInteraction,
    event: UserEvent,
    page: Page,
    memeId: String? = nil,
    memeTitle: String? = nil,
    extraParameters: [String: Any]? = nil
  ) {
    
    var keyName = interaction.rawValue
    if interaction != .scroll {
      keyName += "_" + event.rawValue
    }
    
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
}
