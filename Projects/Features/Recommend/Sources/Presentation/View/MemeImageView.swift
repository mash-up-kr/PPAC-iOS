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
  
  @State var image: URL? = nil
  @Binding var isLoadingImage: Bool
  
  public var body: some View {
    Rectangle()
      .frame(width: 280, height: 280)
      .cornerRadius(20)
      .foregroundColor(.black.opacity(isLoadingImage ? 1 : 0))
      .overlay {
        KFImage(URL(string: imageUrl))
          .placeholder {
            EmptyView()
              .recommendSkeleton(isShow: true, radius: 20, width: 280, height: 280)
          }
          .onSuccess { _ in
            isLoadingImage = true
          }
          .resizable()
          .animation(nil, value: UUID())
          .aspectRatio(contentMode: .fit)
        
        if isDimmed && isLoadingImage {
          RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(Color.Background.dimmer)
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .scrollTransition { content, phase in
        content
          .offset(x: phase.value * -3)
          .scaleEffect(phase.isIdentity ? 1 : 0.9)
          .blur(
            radius: (!isLoadingImage || phase.isIdentity) ? 0 : 1
          )
      }
  }
}

struct MemeImageBorderView: View {
  
  @Binding var isLoadingImage: Bool
  
  public var body: some View {
    RoundedRectangle(cornerRadius: 20)
      .inset(by: 1)
      .stroke(
        Color.Border.primary.opacity(isLoadingImage ? 1 : 0),
        lineWidth: 2
      )
      .frame(width: 280, height: 280)
      .scrollTransition { content, phase in
        content
          .offset(x: phase.value * -3)
          .scaleEffect(phase.isIdentity ? 1 : 0.905)
      }
  }
}

#Preview {
  MemeImageView(
    imageUrl: "https://ppac-meme.s3.ap-northeast-2.amazonaws.com/17204513204087.jpg",
//    imageUrl: "",
    isDimmed: false,
    isLoadingImage: .constant(true)
  )
}
