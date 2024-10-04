//
//  MemeEditorView.swift
//  MemeEditor
//
//  Created by 장혜령 on 9/23/24.
//

import SwiftUI

import DesignSystem
import ResourceKit

struct MemeEditorView: View {
  @ObservedObject private var viewModel: MemeEditorViewModel
  
  public init(viewModel: MemeEditorViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        Rectangle()
          .frame(height: 1)
          .foregroundStyle(Color.Background.assistive)
          .padding(.top, 50)
        ScrollView {
          ImageEditView(
            imageUrl: viewModel.state.memeImageUrl,
            onImageSelectionCompleted: { selectedImage in
              viewModel.state.selectedImage = selectedImage
            }
          )
          memeTitleInputView
          memeSourceInputView
          divider
          memeCategoriesTitleView
          memeCategoriesView
          Spacer(minLength: 48)
        }
        
        if !viewModel.state.isVisibleKeyboard {
          bottomButton
        }
      }
      
      if viewModel.state.needLoadingIndicator {
        ProgressView()
          .scaleEffect(2)
      }
    }
    .onAppear {
      viewModel.dispatch(type: .viewWillAppear)
    }
    .onTapGesture {
      endTextEditing()
    }
    .plainNavigationBar(
      backHandler: {
        viewModel.dispatch(type: .naviBackButtonTapped)
      },
      rightActionHandler: nil,
      hasConfigureButton: false,
      title: "밈 등록하기"
    )
    .popup(
      isActive: $viewModel.state.isActivePopup,
      image: nil,
      text: viewModel.state.contentOfPopup
    )
    .basicModal(
      isPresented: $viewModel.state.isMemeRegistrationSuccess,
      opacity: 0.5,
      content: {
        FarmemeAlertView(
          title: "밈 올리기 성공!",
          description: "마이페이지에서 확인할 수 있어요",
          dismiss: {
            viewModel.dispatch(type: .alertConfirmButtonTapped)
          }
        )
      }
    )
    .onKeyboardChange { isVisible in
      viewModel.state.isVisibleKeyboard = isVisible
    }
  }
  
  private var memeTitleInputView: some View {
    RequiredInputTextFieldView(
      title: "밈의 제목",
      placeHolder: "예) 럭키비키잖아",
      limitedTextCount: 18,
      textViewHeight: 46,
      content: $viewModel.state.memeTitle
    )
    .frame(height: 78)
    .padding(.bottom, 40)
  }
  
  private var memeSourceInputView: some View {
    RequiredInputTextFieldView(
      title: "밈의 출처",
      placeHolder: "예) 무한도전, 핀터레스트",
      limitedTextCount: 32,
      textViewHeight: 82,
      content: $viewModel.state.memeSource
    )
    .frame(height: 114)
    .padding(.bottom, 35)
  }
  
  private var divider: some View {
    Rectangle()
      .frame(height: 10)
      .foregroundStyle(Color.Skeleton.primary)
      .padding(.bottom, 35)
  }
  
  private var memeCategoriesTitleView: some View {
    VStack(alignment: .leading) {
      HStack {
        RequiredTitleView(title: "연관있는 키워드를 골라주세요")
          .padding(.bottom, 4)
        Spacer()
      }
      HStack {
        Text("최대 6개까지 선택 가능해요")
          .foregroundStyle(Color.Text.secondary)
          .font(Font.Body.Medium.medium)
          .padding(.bottom, 24)
        Spacer()
      }
    }
    .padding(.horizontal, 20)
  }
  
  private var memeCategoriesView: some View {
    ForEach($viewModel.state.memeCategories, id: \.id) { $memeCategory in
      let keywordTags = memeCategory.keywords
        .map { KeywordTag(id: $0.id, name: $0.name, isSelected: $0.isSelected) }
      MemeCategoryView(
        category: memeCategory.category,
        keywordTags: keywordTags
      ) { keyword in
        viewModel.dispatch(type: .memeKeywordTapped(keyword: keyword))
        endTextEditing()
      }
    }
    .id(viewModel.state.memeCategories.count)
  }
  
  private var bottomButton: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .padding(.horizontal, 20)
        .foregroundStyle(
          viewModel.state.isMemeFormValid
          ? Color.Background.primary
          : Color.Background.assistive
        )
      Text("등록하기")
        .font(Font.Heading.Small.semiBold)
        .foregroundStyle(
          viewModel.state.isMemeFormValid
          ? Color.Text.inverse
          : Color.Text.disabled
        )
    }
    .frame(height: 48)
    .foregroundStyle(Color.clear)
    .onTapGesture {
      guard viewModel.state.isMemeFormValid else { return }
      viewModel.dispatch(type: .registerButtonTapped)
    }
  }
}

//#Preview {
//  MemeEditorView()
//}
