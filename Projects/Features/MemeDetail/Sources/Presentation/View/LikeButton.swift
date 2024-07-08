//
//  LikeButton.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI

import ResourceKit

public struct LikeButton: View {
  public var body: some View {
    HStack(alignment: .center, spacing: 6) {
      ResourceKitAsset.Icon.ㅋ.swiftUIImage
      Text("개웃겨")
        .font(Font.Family2.outLine)
    }
    .frame(maxWidth: .infinity)
    .frame(height: 46, alignment: .center)
    .background(Color.Skeleton.primary)
    .cornerRadius(10)
  }
}
