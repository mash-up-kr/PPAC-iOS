//
//  MemeItemView.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit
import PPACModels
import Kingfisher

public struct MemeItemView: View {
  private let memeDetail: MemeDetail
  
  public init(memeDetail: MemeDetail) {
    self.memeDetail = memeDetail
  }
  public var body: some View {
    VStack {
      MemeItemViewWithButton(imageUrlString: memeDetail.imageUrlString)
      MemeItemInfoView(memeName: memeDetail.title, reaction: memeDetail.reaction)
    }
    .padding(.bottom, 20)
  }
}

struct MemeItemViewWithButton: View {
  let imageUrlString: String
  @State private var imageHeight: CGFloat = .zero
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      VStack {
        ResizableMemeImageView(imageUrlString: imageUrlString, imageHeight: $imageHeight)
      }
      .frame(height: imageHeight)
      HStack {
        Spacer()
        CircleButton(
          width: 42,
          height: 42,
          image: ResourceKitAsset.Icon.copy.swiftUIImage,
          action: {
            print("Copy~~")
          }
        )
        .padding(20)
      }
    }
  }
}

struct ResizableMemeImageView: View {
  let imageUrlString: String
  @Binding var imageHeight: CGFloat
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        KFImage(URL(string: imageUrlString))
          .resizable()
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .onSuccess { result in
            let ratio = geometry.size.width / result.image.size.width
            imageHeight = result.image.size.height * ratio
          }
          .cornerRadius(12)
          .frame(height: imageHeight)
      }
    }
  }
}


struct MemeItemInfoView: View {
  let memeName: String
  let reaction: Int
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 6) {
        Text(memeName)
          .lineLimit(2)
        if reaction > 0 {
          memeReactionView
        }
        
      }
      .padding(.bottom, 4)
      Spacer()
    }
  }
  
  var memeReactionView: some View {
    HStack {
      Text("ㅋㅋ")
        .font(Font.Family2.outLine)
      Text("\(reaction)")
    }
    .foregroundStyle(Color.Text.tertiary)
  }
}


#Preview {
  MemeItemView(memeDetail: MemeDetail.mock)
}
