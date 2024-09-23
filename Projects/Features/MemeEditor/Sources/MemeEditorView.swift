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
    VStack {
      Divider()
        .padding(.top, 50)
      ScrollView {
        VStack {
          memeTitleInputView
          memeSourceInputView
          divider
        }
      }
    }
    .plainNavigationBar(
      backHandler: {
        viewModel.dispatch(type: .naviBackButtonTapped)
      },
      rightActionHandler: nil,
      hasConfigureButton: false,
      title: "밈 등록하기"
    )
  }
  
  var memeTitleInputView: some View {
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
  
  var memeSourceInputView: some View {
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
  
  var divider: some View {
    Rectangle()
      .frame(height: 10)
      .foregroundStyle(Color.Skeleton.primary)
      .padding(.bottom, 35)
  }
}

//#Preview {
//  MemeEditorView()
//}
