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
  let imageUrl: String
  let isDimmed: Bool
  
  public var body: some View {
    Rectangle()
      .frame(width: 270, height: 310)
      .cornerRadius(20)
      .overlay {
        KFImage(URL(string: imageUrl))
          .resizable()
          .aspectRatio(contentMode: .fit)
        
        if isDimmed {
          RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(Color.Background.dimmer)
        }
      }
  }
}

#Preview {
  MemeImageView(
    imageUrl: "https://ppac-meme.s3.ap-northeast-2.amazonaws.com/17204513204087.jpg",
    isDimmed: false
  )
}
