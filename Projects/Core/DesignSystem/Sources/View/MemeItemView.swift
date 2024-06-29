//
//  MemeItemView.swift
//  DesignSystem
//
//  Created by 장혜령 on 2024/06/29.
//

import SwiftUI
import ResourceKit
public struct MemeItemView: View {
  //private let imageUrl: String
  private let memeName: String
  private let reaction: Int
  public init(memeName: String, reaction: Int) {
    self.memeName = memeName
    self.reaction = reaction
  }
  
  public var body: some View {
    VStack {
      MemeItemViewWithButton()
      MemeItemInfoView(memeName: memeName, reaction: reaction)
    }
  }
}

struct MemeItemViewWithButton: View {
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      VStack {
        Rectangle() // memeImageView가 와야함
          .foregroundStyle(.red)
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
  MemeItemView(memeName: "재성이의 소중한 제보 재성이의 소중한 제보 재성이의 소중한 제보 재성이의 소중한 제보 재성이의 소중한 제보 재성이의 소중한 제보 재성이의 소중한 제보 ",reaction: 10)
}
