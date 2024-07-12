//
//  ImageView.swift
//  Recommend
//
//  Created by 김종윤 on 7/13/24.
//

import SwiftUI
import Kingfisher
import ResourceKit

struct MemeImageView: View {
  private let imageUrl: String
  
  public init(
    imageUrl: String
  ) {
    self.imageUrl = imageUrl
  }
  
  public var body: some View {
    KFImage(URL(string: imageUrl))
      .resizable()
      .frame(width: 270, height: 310)
      .cornerRadius(20)
      .overlay {
        RoundedRectangle(cornerRadius: 20)
          .inset(by: 1)
          .stroke(Color.Border.primary, lineWidth: 2)
      }
  }
}
