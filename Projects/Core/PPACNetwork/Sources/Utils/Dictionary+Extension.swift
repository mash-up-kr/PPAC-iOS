//
//  Dictionary+Extension.swift
//  PPACNetwork
//
//  Created by 장혜령 on 6/8/24.
//

import Foundation

public extension Dictionary where Key == String {
  
  func toJsonString() -> String? {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
      return String(data: jsonData, encoding: .utf8)
    }
    catch {
      print(error.localizedDescription)
    }
    return nil
  }
}
