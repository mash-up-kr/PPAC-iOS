//
//  MemeEditorViewModel.swift
//  MemeEditor
//
//  Created by 장혜령 on 9/23/24.
//

import SwiftUI

import PPACUtil
import PPACModels
import PPACDomain

@MainActor
public protocol MemeEditorRouting: AnyObject {
  func popView()
}

final public class MemeEditorViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case viewWillAppear
    case naviBackButtonTapped
  }
  
  public struct State {
    var memeCategories: [MemeCategory]
    var memeTitle: String
    var memeSource: String
    static let none = State(memeCategories: [], memeTitle: "", memeSource: "")
  }
  
  // MARK: - Properties
  @Published public var state: State
  weak var router: MemeEditorRouting?
  
  private let memeCategorysUseCase: MemeCategorysUseCase
  
  
  public init(
    router: MemeEditorRouting,
    memeCategorysUseCase: MemeCategorysUseCase
  ) {
    self.router = router
    self.state = .none
    self.memeCategorysUseCase = memeCategorysUseCase
  }
  
  public func dispatch(type: Action) {
    Task { @MainActor in
      switch type {
      case .viewWillAppear:
        await fetchMemeCategories()
      case .naviBackButtonTapped:
        router?.popView()
      }
    }
  }
  
  func fetchMemeCategories() async {
    do {
      self.state.memeCategories = try await memeCategorysUseCase.execute()
    } catch(let error) {
      debugPrint("error = \(error)")
    }
  }
  
}
