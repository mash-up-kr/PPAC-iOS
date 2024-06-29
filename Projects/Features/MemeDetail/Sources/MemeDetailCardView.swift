//
//  MemeDetailCardView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI

import PPACModels
import Kingfisher
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
      
      hashTagView
      
        .padding(.bottom, 11)
      
      subtitleLabel
        .padding(.bottom, 20)
      
      likeButton
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
  
  var hashTagView: some View {
    HStack(alignment: .center, spacing: 6) {
      ForEach(self.meme.keywords, id: \.self) { title in
        hashTag(title: title)
      }
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .cornerRadius(40)
  }
  
  var subtitleLabel: some View {
    Text("출처: \(self.meme.source)")
      .font(Font.Body.xsmall)
      .multilineTextAlignment(.center)
      .foregroundColor(Color.Icon.assistive)
    
  }
  
  var likeButton: some View {
    HStack(alignment: .center, spacing: 6) {
      ResourceKitAsset.Icon.ㅋ.swiftUIImage
      ResourceKitAsset.Icon.개웃겨.swiftUIImage
    }
    .frame(maxWidth: .infinity)
    .frame(height: 46, alignment: .center)
    .background(Color.Skeleton.primary)
    .cornerRadius(10)
  }
  
  func hashTag(title: String) -> some View {
    Text("#\(title)")
      .font(Font.Body.large)
      .foregroundColor(Color.Text.tertiary)
  }
}

#Preview {
  MemeDetailCardView(meme: .mock)
}
