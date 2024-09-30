//
//  FarmemeAlertView.swift
//  DesignSystem
//
//  Created by 장혜령 on 9/29/24.
//

import SwiftUI

import ResourceKit

public struct FarmemeAlertView: View {
  private let title: String
  private let description: String
  private var dismiss: (() -> Void)
  
  public init(title: String,
       description: String,
       dismiss: @escaping (() -> Void)
  ) {
    self.title = title
    self.description = description
    self.dismiss = dismiss
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      titleView
      
      descriptionView
        .padding(.top, 8)
      
      confirmButton
        .padding(.top, 14)
    }
    .padding(.horizontal, 30)
    .padding(.vertical, 20)
    .background(Color.Background.white)
    .cornerRadius(20)
  }
  
  
  private var titleView: some View {
    HStack {
      Text(title)
        .font(Font.Heading.Medium.semiBold)
        .foregroundColor(Color.Text.primary)
        .foregroundColor(.black)
      Spacer()
    }
  }
  
  private var descriptionView: some View {
    HStack {
      Text(description)
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
