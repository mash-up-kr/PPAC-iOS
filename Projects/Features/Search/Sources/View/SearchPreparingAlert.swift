//
//  SearchPreparingAlert.swift
//  Search
//
//  Created by 리나 on 2024/06/30.
//

import SwiftUI
import ResourceKit

struct SearchPreparingAlert: View {
  private var dismiss: (() -> Void)
  
  init(dismiss: @escaping (() -> Void)) {
    self.dismiss = dismiss
  }
  
  var body: some View {
    VStack(spacing: 0) {
      title
      
      description
        .padding(.top, 8)
      
      confirmButton
        .padding(.top, 14)
    }
    .padding(.horizontal, 30)
    .padding(.vertical, 20)
    .background(Color.Background.white)
    .cornerRadius(20)
  }
  
  
  private var title: some View {
    HStack {
      Text("조금만 기다려주세요!")
        .font(Font.Heading.Medium.semiBold)
        .foregroundColor(Color.Text.primary)
        .foregroundColor(.black)
      Spacer()
    }
  }
  
  private var description: some View {
    HStack {
      Text("검색은 준비 중이에요.")
        .font(Font.Body.Large.medium)
        .foregroundColor(Color.Text.secondary)
        .multilineTextAlignment(.leading)
      Spacer()
    }
  }
  
  private var confirmButton: some View {
    HStack{
      Spacer()
      Button {
        dismiss()
      } label: {
        Text("확인")
          .font(Font.Body.Large.medium)
          .foregroundColor(Color.Text.brand)
      }
    }
  }
}
