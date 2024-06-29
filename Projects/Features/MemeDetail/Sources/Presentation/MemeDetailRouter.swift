//
//  MemeDetailRouter.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import UIKit
import SwiftUI

import PPACUtil
import PPACModels

final class MemeDetailRouter: Router {
  
  
  // MARK: - Properties
  
  var delegate: (any RouterDelegate)?
  
  var navigationController: UINavigationController
  
  var childRouters: [any Router] = []
  
  let meme: MemeDetail
  
  // MARK: - Initializers
  
  init(_ navigationController: UINavigationController, meme: MemeDetail) {
      navigationController.isNavigationBarHidden = true
      self.meme = meme
      self.navigationController = navigationController
  }
  
  // MARK: - Methods
  
  func start() {
      self.pushView(MemeDetailView(meme: meme))
  }

}
