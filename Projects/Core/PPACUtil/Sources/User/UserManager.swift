//
//  UserManager.swift
//  PPACUtil
//
//  Created by 장혜령 on 2024/07/11.
//

import Foundation

public class UserManager {
  @UserDefault(key:"memeLevel", defaultValue: 1)
  public static var memeLevel: Int
  
  @UserDefault(key:"uuid", defaultValue: "")
  public static var uuid: String
  
  public static func setupUserUUID() {
    if uuid.isEmpty {
      uuid = UUID().uuidString
    }
  }
}
