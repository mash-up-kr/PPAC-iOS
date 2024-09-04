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
import SkeletonUI

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
  @State private var isImageLoaded: Bool = false
  
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
  @State private var isImageLoaded: Bool = false
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        KFImage(URL(string: imageUrlString))
          .resizable()
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .onSuccess { result in
            guard result.image.size.width > 0 else { return }
            let ratio = geometry.size.width / result.image.size.width
            let newHeight = result.image.size.height * ratio
            if newHeight < 80 {
              imageHeight = 80
            } else if newHeight > 300 {
              imageHeight = 300
            } else {
              imageHeight = newHeight
            }
            isImageLoaded = true
          }
          .cornerRadius(12)
          .frame(height: imageHeight)
          .opacity(isImageLoaded ? 1 : 0) // 이미지 로드 완료 전에 투명하게 처리
        
//        if !isImageLoaded {
//          skeletonView
//            .onAppear {
//              imageHeight = geometry.size.width
//            }
//        }
      }
    }
  }
  
  var skeletonView: some View {
    EmptyView()
      .skeleton(
        with: !isImageLoaded,
        animation: .linear(duration: 2, delay: 0, speed: 1),
        appearance: .gradient(
          .linear,
          color: Color.Skeleton.secondary,
          background: Color.Skeleton.primary,
          radius: 1
        ),
        shape: .rounded(.radius(12))
      )
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
