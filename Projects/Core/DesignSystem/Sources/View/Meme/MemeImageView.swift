//
//  MemeImageView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/29/24.
//

import SwiftUI
import ResourceKit
import Kingfisher
import SkeletonUI

public struct MemeImageView: View {
  
  // MARK: - Properties
  
  private let imageUrlString: String
  @State private var isImageLoaded: Bool = false
  // MARK: - Initializers
  
  public init(imageUrlString: String) {
    self.imageUrlString = imageUrlString
  }
  
  // MARK: - UI
  
  public var body: some View {
    KFImage(URL(string: imageUrlString))
      .placeholder {
        skeletonView
      }
      .onSuccess { _ in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          isImageLoaded = true
        }
      }
      .resizable()
      .loadDiskFileSynchronously()
      .cacheMemoryOnly()
      .fade(duration: 0.25)
      .frame(maxWidth: .infinity)
      .aspectRatio(contentMode: .fit)
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
