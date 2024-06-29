//
//  HotKeywordImageView.swift
//  Search
//
//  Created by 리나 on 2024/06/30.
//

import SwiftUI
import Kingfisher
import PPACModels
import DesignSystem
import ResourceKit

struct HotKeywordImageView: View, HorizontalMimItemViewProtocol {
  typealias Item = HotKeyword
  
  let hotKeyword: HotKeyword
  
  init(item hotKeyword: HotKeyword) {
    self.hotKeyword = hotKeyword
  }
  
  var body: some View {
    ZStack {
      KFImage(URL(string: hotKeyword.imageUrlString))
        .resizable()
        .loadDiskFileSynchronously()
        .cacheMemoryOnly()
        .frame(width: 90, height: 90)
        .aspectRatio(contentMode: .fit)
      
      Color.black.opacity(0.4)
      
      Text(hotKeyword.title)
        .font(Font.Body.Large.semiBold)
        .foregroundColor(Color.Text.inverse)
        .lineLimit(2)
        .multilineTextAlignment(.center)
        .padding(.horizontal, 16)
        .frame(width: 90, height: 90)
    }
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .inset(by: 1)
        .stroke(Color.Border.primary, lineWidth: 2)
    )
    .clipShape(RoundedRectangle(cornerRadius: 10))
  }
}
