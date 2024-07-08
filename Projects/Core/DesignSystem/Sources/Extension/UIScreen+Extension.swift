//
//  UIScreen+Extension.swift
//  PPACUtil
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI

public struct ScreenSizeKey: EnvironmentKey {
  public static let defaultValue: CGSize = UIScreen.main.bounds.size
}

public extension EnvironmentValues {
  var screenSize: CGSize {
    get { self[ScreenSizeKey.self] }
    set { self[ScreenSizeKey.self] = newValue }
  }
}
