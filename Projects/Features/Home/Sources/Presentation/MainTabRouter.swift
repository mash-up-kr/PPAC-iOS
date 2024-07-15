//
//  MainTabRouter.swift
//  Home
//
//  Created by 장혜령 on 2024/07/11.
//

import UIKit
import SwiftUI

import PPACUtil
import PPACModels

public protocol MainTabRouting: AnyObject { }

public final class MainTabRouter: Router, MainTabRouting {
  
  // MARK: - Properties
  public var delegate: (any RouterDelegate)?
  
  public var navigationController: UINavigationController
  
  public var childRouters: [any Router] = []
  
  public var userDetail: UserDetail
  
  // MARK: - Initializers
  
  public init(
    _ navigationController: UINavigationController,
    userDetail: UserDetail
  ){
    self.navigationController = navigationController
    self.userDetail = userDetail
  }
  
  // MARK: - Methods
  public func start() {
    self.pushView(
      MainTabView(userDetail: userDetail),
      animated: false
    )
  }
}
