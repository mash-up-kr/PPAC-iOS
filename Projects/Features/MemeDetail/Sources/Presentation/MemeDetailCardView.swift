//
//  MemeDetailCardView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI

import DesignSystem
import PPACModels
import ResourceKit


struct MemeDetailCardView: View {
  
  // MARK: - Properties
  
  let meme: MemeDetail
  
  // MARK: - UI
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      
      MemeImageView(imageUrlString: meme.imageUrlString)
        .padding(.bottom, 25)
      
      titleLabel
        .padding(.bottom, 5)
      
      HashTagView(keywords: meme.keywords)
        .padding(.bottom, 11)
      
      subtitleLabel
        .padding(.bottom, 20)
      
      LikeButton()
        .padding(.bottom, 20)
    }
    .padding(10)
    .background(.white)
    .cornerRadius(20)
    .overlay(
      RoundedRectangle(cornerRadius: 20)
        .inset(by: 1)
        .stroke(.black, lineWidth: 2)
    )
    .padding(.horizontal, 24)
  }
  
  // MARK: - Methods
  
  var titleLabel: some View {
    Text(meme.title)
      .font(Font.Heading.large.weight(.semibold))
      .multilineTextAlignment(.center)
      .foregroundColor(Color.Text.primary)
      .frame(maxWidth: .infinity, alignment: .center)
  }
  
  var subtitleLabel: some View {
    Text("출처: \(self.meme.source)")
      .font(Font.Body.xsmall)
      .multilineTextAlignment(.center)
      .foregroundColor(Color.Icon.assistive)
  }
}

#Preview {
  MemeDetailCardView(meme: .mock)
}
