//
//  MemeImageView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI

import Kingfisher

struct MemeImageView: View {
  
  // MARK: - Properties
  
  private let imageUrlString: String
  
  // MARK: - Initializers
  
  init(imageUrlString: String) {
    self.imageUrlString = imageUrlString
  }
  
  // MARK: - UI
  
  var body: some View {
    KFImage(URL(string: imageUrlString))
      .resizable()
      .loadDiskFileSynchronously()
      .cacheMemoryOnly()
      .fade(duration: 0.25)
      .frame(maxWidth: .infinity)
      .aspectRatio(0.9375, contentMode: .fit)
      .cornerRadius(10)
  }
}
