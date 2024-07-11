//
//  HomeRouter.swift
//  Home
//
//  Created by 장혜령 on 2024/07/11.
//

import UIKit
import SwiftUI

import PPACUtil
import PPACModels

public protocol HomeRouting: AnyObject { }

public final class HomeRouter: Router, HomeRouting {
  
  // MARK: - Properties
  public var delegate: (any RouterDelegate)?
  
  public var navigationController: UINavigationController
  
  public var childRouters: [any Router] = []
  
  // MARK: - Initializers
  
  public init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: - Methods
  public func start() {
    self.pushView(
      MainTabView()
    )
  }
}
