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
  //func showImagePicker()
}

final public class MemeEditorViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case viewWillAppear
    case naviBackButtonTapped
    case memeKeywordTapped(keyword: String)
    case registerButtonTapped
  }
  
  public struct State {
    var memeImageUrl: String // 나중에 수정하기에 쓸 수 있도록 남겨둠
    var selectedImage: UIImage?
    var memeTitle: String
    var memeSource: String
    var memeCategories: [MemeCategory]
    var selectedMemeKeywords: [MemeKeyword] = []
    
    var isActivePopup: Bool = false
    var contentOfPopup: String = ""
    
    var isMemeFormValid: Bool {
      return selectedImage != nil
      && !memeTitle.isEmpty
      && !memeSource.isEmpty
      && !selectedMemeKeywords.isEmpty
      && selectedMemeKeywords.count <= 6
    }
    
    static let none = State(memeImageUrl: "empty", selectedImage: nil, memeTitle: "", memeSource: "", memeCategories: [])
  }
  
  // MARK: - Properties
  @Published public var state: State
  weak var router: MemeEditorRouting?
  
  private let memeCategorysUseCase: MemeCategorysUseCase
  
  private var allKeywords: [MemeKeyword] {
    return self.state.memeCategories
      .map { $0.keywords }
      .flatMap { $0 }
  }
  
  
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
      case .memeKeywordTapped(let keyword):
        self.updateSelectedMemeKeyword(keyword)
      case .registerButtonTapped:
        print("===============================")
        print("selectedImage = \(state.selectedImage)")
        print("title = \(state.memeTitle)")
        print("source = \(state.memeSource)")
        print("keywords = \(state.selectedMemeKeywords)")
        print("===============================")
      }
    }
  }
  
  @MainActor
  private func fetchMemeCategories() async {
    do {
      self.state.memeCategories = try await memeCategorysUseCase.execute()
    } catch(let error) {
      debugPrint("error = \(error)")
    }
  }
  
  private func updateSelectedMemeKeyword(_ keyword: String) {
    guard var selectedKeyword = self.allKeywords
      .first(where: { $0.name == keyword })else { return }
    
    // 선택된 키워드가 있다면 삭제, 없다면 추가
    if let hasSelectedkeywordIndex = self.state.selectedMemeKeywords.firstIndex(where: {$0.id == selectedKeyword.id}) {
      self.state.selectedMemeKeywords.remove(at: hasSelectedkeywordIndex)
      selectedKeyword.isSelected = false
    } else if self.state.selectedMemeKeywords.count >= 6 {
      self.showToast(text: "최대 개수를 초과했어요")
      return
    } else {
      self.state.selectedMemeKeywords.append(selectedKeyword)
      selectedKeyword.isSelected = true
    }
    
    for (categoryIndex, category) in self.state.memeCategories.enumerated() {
      if let keywordIndex = category.keywords.firstIndex(where: { $0.id == selectedKeyword.id }) {
        var newKeywords = self.state.memeCategories[categoryIndex].keywords
        newKeywords[keywordIndex] = selectedKeyword
        self.state.memeCategories[categoryIndex].keywords = newKeywords
      }
    }
  }
  
  private func showToast(text: String) {
    self.state.contentOfPopup = text
    self.state.isActivePopup = true
  }
}
