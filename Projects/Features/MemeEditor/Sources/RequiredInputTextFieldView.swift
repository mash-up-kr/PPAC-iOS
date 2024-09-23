//
//  RequiredInputTextFieldView.swift
//  MemeEditor
//
//  Created by 장혜령 on 2024/09/20.
//

import SwiftUI
import ResourceKit

struct RequiredTitleView: View {
  let title: String
  
  var body: some View {
    HStack {
      Text(title)
        .font(Font.Body.Xlarge.semiBold)
        .foregroundStyle(Color.Text.primary)
      ResourceKitAsset.Icon.starMarker.swiftUIImage
        .resizable()
        .frame(width: 12, height: 12)
        .padding(.leading, -4)
        .padding(.bottom, 10)
    }
  }
}

struct RequiredInputTextFieldView: View {
  let title: String
  let placeHolder: String
  let limitedTextCount: Int
  let textViewHeight: CGFloat
  @Binding var content: String
  
  var currentTextCount: Int {
    return content.count
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      RequiredTitleView(title: title)
        .padding(.bottom, 8)
      textFieldWithTextCountView
    }
    .padding(.horizontal, 20)
  }
  
  var textFieldWithTextCountView: some View {
    ZStack(alignment: .bottomTrailing) {
      textFieldView
      textCountView
    }
  }
  
  var textFieldView: some View {
    ZStack(alignment: .topLeading) {
      RoundedRectangle(cornerRadius: 10)
        .foregroundStyle(Color.Background.assistive)
      Text(placeHolder)
        .foregroundStyle(content.isEmpty ? Color.Text.assistive : Color.clear)
        .font(Font.Body.Large.medium)
        .padding(.horizontal, 16)
        .padding(.top, 12)
      TextEditor(text: $content)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .padding(.horizontal, 12)
        .padding(.top, 4)
        .font(Font.Body.Large.medium)
        .foregroundStyle(Color.Text.primary)
        .onChange(of: content) { _ , newValue in
          if newValue.count > limitedTextCount {
            content = String(newValue.prefix(limitedTextCount))
          }
        }
    }
  }
  
  var textCountView: some View {
    HStack(spacing: 2) {
      currentTextCountView
      Text("/")
      Text("\(limitedTextCount)")
    }
    .padding(.trailing, 16)
    .padding(.bottom, 14)
    .foregroundStyle(Color.Text.assistive)
    .font(Font.Body.Medium.medium)
  }
  
  var currentTextCountView: some View {
    return Text("\(currentTextCount)")
      .foregroundStyle(currentTextColor)
  }
  
  var currentTextColor: SwiftUI.Color {
    if currentTextCount == 0 {
      return Color.Text.assistive
    } else if currentTextCount >= limitedTextCount {
      return Color.Text.brand
    }
    return Color.Text.secondary
  }
  
}

#Preview {
  @Previewable @State var content: String = ""
  
  return RequiredInputTextFieldView(
    title: "밈의 제목을 작성해주세요",
    placeHolder: "예) 무한도전, 핀터레스트",
    limitedTextCount: 32,
    textViewHeight: 82,
    content: $content
  )
}
