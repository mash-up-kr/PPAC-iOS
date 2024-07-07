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

public final class MemeDetailRouter: Router, MemeDetailRouting {
  
  // MARK: - Properties
  
  public var delegate: (any RouterDelegate)?
  
  public var navigationController: UINavigationController
  
  public var childRouters: [any Router] = []
  
  let meme: MemeDetail
  
  // MARK: - Initializers
  
  public init(_ navigationController: UINavigationController, meme: MemeDetail) {
      navigationController.isNavigationBarHidden = true
      self.meme = meme
      self.navigationController = navigationController
  }

  // MARK: - Methods
  
  public func start() {
    self.pushView(
      MemeDetailView(
        viewModel: MemeDetailViewModel(
          meme: self.meme,
          router: self,
          postLikeUseCase: PostLikeUseCaseImpl()
        )
      )
    )
  }
  
  public func showShareView(items: [Any]) {
    let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
    self.navigationController.present(vc, animated: true)
  }
}
