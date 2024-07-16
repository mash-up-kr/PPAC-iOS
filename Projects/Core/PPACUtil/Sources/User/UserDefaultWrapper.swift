//
//  UserDefaultWrapper.swift
//  PPACUtil
//
//  Created by 장혜령 on 2024/07/11.
//

import Foundation

@propertyWrapper
public struct UserDefault<T: Codable> {
  
  public let key: String
  public let defaultValue: T
  public let userDefaults: UserDefaults
  
  public var wrappedValue: T {
    get {
      guard let data = userDefaults.data(forKey: key) else {
        return defaultValue
      }
      let decoder = JSONDecoder()
      return (try? decoder.decode(T.self, from: data)) ?? defaultValue
    }
    set {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(newValue) {
        userDefaults.set(encoded, forKey: key)
      }
    }
  }
  
  public init(key: String, defaultValue: T, userDefaults: UserDefaults = .standard ) {
    self.key = key
    self.defaultValue = defaultValue
    self.userDefaults = userDefaults
  }
}
