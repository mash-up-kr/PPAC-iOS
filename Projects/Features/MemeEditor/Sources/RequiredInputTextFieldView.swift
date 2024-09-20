//
//  RequiredInputTextFieldView.swift
//  MemeEditor
//
//  Created by 장혜령 on 2024/09/20.
//

import SwiftUI
import ResourceKit

struct RequiredInputTextFieldView: View {
  let title: String
  let placeHolder: String
  let limitedTextCount: Int
  @State var content: String = ""
  
  var currentTextCount: Int {
    return content.count
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      titleView
        .padding(.bottom, 12)
      textFieldView
    }
    
  }
  
  var titleView: some View {
    HStack {
      Text(title)
        .font(Font.Body.Xlarge.semiBold)
        .foregroundStyle(Color.Text.primary)
      ResourceKitAsset.Icon.starMarker.swiftUIImage
        .resizable()
        .frame(width: 12, height: 12)
        .padding(.leading, -8)
        .padding(.bottom, 10)
    }
  }
  
  var textFieldView: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .foregroundStyle(Color.Background.assistive)
      TextField(placeHolder, text: $content)
        .font(Font.Body.Large.medium)
        .padding(.leading, 16)
        .padding(.top, 14)
    }
  }
  
  var textCountView: some View {
    HStack(spacing: 2) {
      currentTextCountView
      Text("/")
      Text("")
    }
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
    } else if currentTextCount <= limitedTextCount {
      return Color.Text.brand
    }
    return Color.Text.secondary
  }
  
}

#Preview {
  RequiredInputTextFieldView(
    title: "밈의 제목을 작성해주세요",
    placeHolder: "예) 무한도전, 핀터레스트",
    limitedTextCount: 32
  )
}
