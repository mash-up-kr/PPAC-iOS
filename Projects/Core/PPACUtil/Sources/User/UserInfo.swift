//
//  UserInfo.swift
//  PPACUtil
//
//  Created by 장혜령 on 2024/07/11.
//

import Foundation

public class UserInfo {
  
  public static let shared = UserInfo()
  
  private init() {}
  
  @UserDefault(key:"memeLevel", defaultValue: 1)
  public var memeLevel: Int
  
  @UserDefault(key:"deviceId", defaultValue: "")
  public var deviceId: String
 
  public let testDeviceId: String = "abcdefgh"
}
