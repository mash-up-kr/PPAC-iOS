//
//  MemeItemView.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit
import PPACModels

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
  }
}

struct MemeItemViewWithButton: View {
  let imageUrlString: String
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      VStack {
        MemeImageView(imageUrlString: imageUrlString)
      }
      HStack {
        Spacer()
        CircleCopyButton()
          .padding(20)
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
      .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 0))
      Spacer()
    }
  }
  
  var memeReactionView: some View {
    HStack {
      ResourceKitAsset.Icon.ㅋㅋ.swiftUIImage
        .renderingMode(.template)
      Text("\(reaction)")
    }
    .foregroundStyle(Color.Text.tertiary)
  }
}


#Preview {
  MemeItemView(memeDetail: MemeDetail.mock)
}
