//
//  RecommendRouter.swift
//  Recommend
//
//  Created by 김종윤 on 7/6/24.
//

import UIKit
import SwiftUI
import PPACUtil
import PPACModels

final class RecommendRouter: Router {
  
  // MARK: - Properties
  
  var delegate: (any RouterDelegate)?
  
  var navigationController: UINavigationController
  
  var childRouters: [any Router] = []
  
  // MARK: - Initializers
  
  init(_ navigationController: UINavigationController) {
    navigationController.isNavigationBarHidden = true
    self.navigationController = navigationController
  }
  
  // MARK: - Methods
  
  func start() {
    self.pushView(EmptyView())
  }
  
}
