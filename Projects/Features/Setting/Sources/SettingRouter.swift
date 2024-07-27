//
//  SettingRouter.swift
//  Setting
//
//  Created by 장혜령 on 2024/07/21.
//
import UIKit

import PPACUtil

public final class SettingRouter: Router, SettingRouting {
 
  // MARK: - Properties
  public var delegate: (any RouterDelegate)?
  public var navigationController: UINavigationController
  public var childRouters: [any Router] = []
 
  
  // MARK: - Initializers
  public init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let settingView = SettingView(
      viewModel: SettingViewModel(router: self)
    )
    self.pushView(settingView)
  }
}
