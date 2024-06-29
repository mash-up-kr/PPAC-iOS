//
//  MemeImageView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI
import Kingfisher

public struct MemeImageView: View {
  
  // MARK: - Properties
  
  private let imageUrlString: String
  
  // MARK: - Initializers
  
  public init(imageUrlString: String) {
    self.imageUrlString = imageUrlString
  }
  
  // MARK: - UI
  
  public var body: some View {
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
