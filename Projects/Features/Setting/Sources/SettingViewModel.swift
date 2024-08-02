//
//  SettingViewModel.swift
//  Setting
//
//  Created by 장혜령 on 2024/07/21.
//

import Foundation
import PPACUtil

@MainActor
public protocol SettingRouting: AnyObject {
  func popView()
}

final public class SettingViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case naviBackButtonTapped
  }
  
  public struct State {
    var currnetAppVersion: String = ""
    var needUpdate: Bool = false
    var settingList: [SettingType] = []
  }
  
  // MARK: - Properties
  weak var router: SettingRouting?
  @Published public var state: State
  
  // MARK: - Initializers
  public init(router: SettingRouting? = nil) {
    self.router = router
    self.state = State()
    self.state.needUpdate = self.checkNeedUpdate()
    self.state.currnetAppVersion = self.getCurrentAppVersion()
    self.initSettingList()
  }
  
  private func initSettingList() {
    var settingList = [SettingType]()
    settingList.append(
      SettingType(url: "https://www.google.com", title: "개인정보 처리 방침")
    )
    self.state.settingList = settingList
  }
  
  // MARK: - Methods
  @MainActor
  public func dispatch(type: Action) {
    switch type {
    case .naviBackButtonTapped:
      router?.popView()
    }
  }
  
  private func getCurrentAppVersion() -> String {
    let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    return currentVersion ?? ""
  }
  
  private func checkNeedUpdate() -> Bool {
    guard let appStoreVersion = self.getLatestVersion() else { return false }
    let currentVersion = getCurrentAppVersion()
    print("Setting | currentVersion = \(currentVersion)")
    print("Setting | appStoreVersion = \(appStoreVersion)")
    
    return currentVersion != appStoreVersion
  }
  
  private func getLatestVersion() -> String? {
//    guard
//      let bundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
//      let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleIdentifier)"),
//      let data = try? Data(contentsOf: url),
//      let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//      let results = json["results"] as? [[String: Any]], !results.isEmpty,
//      let appStoreVersion = results[0]["version"] as? String else {
//      return nil
//    }
//    return appStoreVersion
    return nil
  }
}

public struct SettingType: Identifiable {
  public let id = UUID()
  public let url: String
  public let title: String
  
  init(
    url: String,
    title: String
  ) {
    self.url = url
    self.title = title
  }
}
