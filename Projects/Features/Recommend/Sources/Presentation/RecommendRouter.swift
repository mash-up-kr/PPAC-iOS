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

public final class RecommendRouter: Router, RecommendRouting {
  
  // MARK: - Properties
  
  public var delegate: (any RouterDelegate)?
  
  public var navigationController: UINavigationController
  
  public var childRouters: [any Router] = []
  
  let recommendMemes: [MemeDetail]
  let user: UserDetail
  
  // MARK: - Initializers
  
  public init(
    _ navigationController: UINavigationController,
    recommendMemes: [MemeDetail],
    user: UserDetail
  ) {
    navigationController.isNavigationBarHidden = true
    self.navigationController = navigationController
    self.recommendMemes = recommendMemes
    self.user = user
  }
  
  // MARK: - Methods
  
  public func start() {
    self.pushView(EmptyView())
  }
  
}
