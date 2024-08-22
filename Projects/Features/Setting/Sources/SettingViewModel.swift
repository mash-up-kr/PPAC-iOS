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
    case checkNeedUpdate
  }
  
  public struct State {
    var currnetAppVersion: String = ""
    var needUpdate: Bool = false
    var settingList: [SettingType] = []
  }
  
  // MARK: - Properties
  weak var router: SettingRouting?
  @Published public var state: State
  private let appId: String = "6532618484"
  var appStoreUrl: URL {
    return URL(string: "itms-apps://itunes.apple.com/app/\(appId)")!
  }
  
  // MARK: - Initializers
  public init(router: SettingRouting? = nil) {
    self.router = router
    self.state = State()
    
    self.state.currnetAppVersion = "v." + self.getCurrentAppVersion()
    self.initSettingList()
    
    self.dispatch(type: .checkNeedUpdate)
  }
  
  private func initSettingList() {
    var settingList = [SettingType]()
    settingList.append(
      SettingType(
        url: "https://snow-chestnut-45b.notion.site/03c44635666546718a4540874f824cd7?pvs=4",
        title: "개인정보 처리 방침"
      )
    )
    self.state.settingList = settingList
  }
  
  // MARK: - Methods
  public func dispatch(type: Action) {
    Task { @MainActor in
      switch type {
      case .naviBackButtonTapped:
        router?.popView()
      case .checkNeedUpdate:
        self.state.needUpdate = await checkNeedUpdate()
      }
    }
  }
  
  private func getCurrentAppVersion() -> String {
    let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    return currentVersion ?? ""
  }
  
  private func checkNeedUpdate() async -> Bool {
    guard let appStoreVersion = await self.getLatestVersion() else { return false }
    let currentVersion = self.getCurrentAppVersion()
    return currentVersion != appStoreVersion
  }
  
  private func getLatestVersion() async -> String? {
    guard let bundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
          let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleIdentifier)&country=kr") else {
      return nil
    }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
         let results = json["results"] as? [[String: Any]], !results.isEmpty,
         let appStoreVersion = results[0]["version"] as? String {
        return appStoreVersion
      }
    } catch {
      print("Failed to fetch latest version: \(error)")
    }
    
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
