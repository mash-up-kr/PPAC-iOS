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
import PPACNetwork

@MainActor
public protocol MemeEditorRouting: AnyObject {
  func popView()
}

final public class MemeEditorViewModel: ViewModelType, ObservableObject {
  
  public enum Action {
    case viewWillAppear
    case naviBackButtonTapped
    case memeKeywordTapped(keyword: String)
    case registerButtonTapped
    case alertConfirmButtonTapped
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
    var isMemeRegistrationSuccess: Bool = false
    var needLoadingIndicator: Bool = false
    
    var isMemeFormValid: Bool {
      return selectedImage != nil
      && !memeTitle.isEmpty
      && !memeSource.isEmpty
      && !selectedMemeKeywords.isEmpty
      && selectedMemeKeywords.count <= 6
    }
    
    static let none = State(memeImageUrl: "empty", selectedImage: nil, memeTitle: "", memeSource: "", memeCategories: [])
  }
  
  enum MemeError: Error {
      case imageNotAvailable
  }
  
  // MARK: - Properties
  @Published public var state: State
  weak var router: MemeEditorRouting?
  
  private let memeCategorysUseCase: MemeCategorysUseCase
  private let registerMemeUserCase: RegisterMemeUseCase
  
  private var allKeywords: [MemeKeyword] {
    return self.state.memeCategories
      .map { $0.keywords }
      .flatMap { $0 }
  }
  
  
  public init(
    router: MemeEditorRouting,
    memeCategorysUseCase: MemeCategorysUseCase,
    registerMemeUserCase: RegisterMemeUseCase
  ) {
    self.router = router
    self.state = .none
    self.memeCategorysUseCase = memeCategorysUseCase
    self.registerMemeUserCase = registerMemeUserCase
  }
  
  public func dispatch(type: Action) {
    Task { @MainActor in
      switch type {
      case .viewWillAppear:
        await fetchMemeCategories()
      case .naviBackButtonTapped:
        router?.popView()
      case .memeKeywordTapped(let keyword):
        await self.updateSelectedMemeKeyword(keyword)
      case .registerButtonTapped:
        print("===============================")
        print("selectedImage = \(state.selectedImage)")
        print("title = \(state.memeTitle)")
        print("source = \(state.memeSource)")
        print("keywords = \(state.selectedMemeKeywords)")
        print("===============================")
        await self.registMeme()
      case .alertConfirmButtonTapped:
        router?.popView()
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
  
  @MainActor
  private func updateSelectedMemeKeyword(_ keyword: String) async {
    guard var selectedKeyword = self.allKeywords
      .first(where: { $0.name == keyword }) else { return }
    
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
  
  @MainActor
  private func registMeme() async {
    do {
      let imageFormData = try self.getImageFormData()
      self.state.needLoadingIndicator = true
      try await self.registerMemeUserCase
        .execute(
          formData: imageFormData,
          title: self.state.memeTitle,
          source: self.state.memeSource,
          keywordIds: self.state.selectedMemeKeywords.map { $0.id }
        )
      
      self.state.isMemeRegistrationSuccess = true
      self.state.needLoadingIndicator = false
    } catch MemeError.imageNotAvailable {
      self.showToast(text: "지원하지 않는 이미지 형식입니다. 다른 이미지를 사용해주세요")
      self.state.needLoadingIndicator = false
    } catch(let error) {
      print("error = \(error)")
      self.showToast(text: "밈 등록에 실패했어요")
      self.state.needLoadingIndicator = false
    }
  }
  
  private func getImageFormData() throws -> FormData {
    guard let imageData = self.state.selectedImage?.jpegData(compressionQuality: 0.8) else {
      throw MemeError.imageNotAvailable
    }
    let formData = FormData(
        fieldName: "image",
        fileName: "image_\(UUID().uuidString.replacingOccurrences(of: "-", with: "_")).jpg",
        mimeType: "image/jpeg",
        fileData: imageData
    )
    return formData
  }
  
  @MainActor
  private func showToast(text: String) {
    self.state.contentOfPopup = text
    self.state.isActivePopup = true
  }
}
