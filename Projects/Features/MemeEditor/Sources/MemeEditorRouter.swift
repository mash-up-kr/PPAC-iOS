//
//  MemeEditorRouter.swift
//  MemeEditor
//
//  Created by 장혜령 on 9/23/24.
//

import UIKit

import PPACUtil
import PPACData
import PPACNetwork
import PPACDomain

public final class MemeEditorRouter: Router, MemeEditorRouting {
  
  // MARK: - Properties
  public var delegate: (any RouterDelegate)?
  public var navigationController: UINavigationController
  public var childRouters: [any Router] = []
  
  // MARK: - Initializers
  public init(
    navigationController: UINavigationController
  ) {
    self.navigationController = navigationController
  }
  
  public func start() {
    let repository = KeywordRepositoryImpl(networkService: NetworkService())
    
    let memeEditorView = MemeEditorView(
      viewModel: MemeEditorViewModel(
        router: self,
        memeCategorysUseCase: MemeCategorysUseCaseImpl(repository: repository)
      )
    )
    
    self.pushView(memeEditorView)
  }
    
}
