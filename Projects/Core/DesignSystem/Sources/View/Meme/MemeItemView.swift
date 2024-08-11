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
  private let memeClickHandler: ((MemeDetail) -> ())?
  private let memeCopyHandler: ((MemeDetail) -> ())?
  
  public init(
    memeDetail: MemeDetail,
    memeClickHandler: ((MemeDetail) -> ())? = nil,
    memeCopyHandler: ((MemeDetail) -> ())? = nil
  ) {
    self.memeDetail = memeDetail
    self.memeClickHandler = memeClickHandler
    self.memeCopyHandler = memeCopyHandler
  }
  
  public var body: some View {
    VStack(spacing: 10) {
      MemeItemViewWithButton(memeDetail: memeDetail, memeCopyHandler: memeCopyHandler)
        .onTapGesture {
          memeClickHandler?(memeDetail)
        }
      MemeItemInfoView(memeName: memeDetail.title, reaction: memeDetail.reaction)
    }
  }
}

struct MemeItemViewWithButton: View {
  @State private var imageHeight: CGFloat = .zero
  private let memeCopyHandler: ((MemeDetail) -> ())?
  private let memeDetail: MemeDetail
  
  init(memeDetail: MemeDetail, memeCopyHandler: ((MemeDetail) -> ())?) {
    self.memeDetail = memeDetail
    self.memeCopyHandler = memeCopyHandler
  }
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      VStack {
        ResizableMemeImageView(
          imageUrlString: memeDetail.imageUrlString,
          imageHeight: $imageHeight
        )
      }
      .frame(height: imageHeight)
      HStack {
        Spacer()
        CircleButton(
          width: 42,
          height: 42,
          image: ResourceKitAsset.Icon.copy.swiftUIImage,
          action: {
            memeCopyHandler?(memeDetail)
          }
        )
        .padding(10)
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
            let newHeight = result.image.size.height * ratio
            if newHeight < 80 {
              imageHeight = 80
            } else if newHeight > 300 {
              imageHeight = 300
            } else {
              imageHeight = newHeight
            }
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
          .font(Font.Body.Medium.medium)
          .lineLimit(2)
        if reaction > 0 {
          memeReactionView
        }
        
      }
      Spacer()
    }
    .padding(.horizontal, 4)
  }
  
  var memeReactionView: some View {
    HStack(spacing: 4) {
      Text("ㅋㅋ")
        .font(Font.Family2.xlarge)
      Text("\(reaction)")
        .font(Font.Body.Small.medium)
    }
    .foregroundStyle(Color.Text.tertiary)
  }
}


#Preview {
  MemeItemView(memeDetail: MemeDetail.mock)
}
