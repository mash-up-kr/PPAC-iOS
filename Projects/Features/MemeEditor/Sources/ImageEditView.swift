//
//  ImageEditView.swift
//  MemeEditor
//
//  Created by 장혜령 on 9/24/24.
//

import SwiftUI

import ResourceKit
import DesignSystem

import Kingfisher

public struct ImageEditView: View {

  private let imageUrl: String
  @State private var selectedImage: UIImage?
  private var onImageSelectionCompleted: ((UIImage?) -> ())?
  
  @Environment(\.screenSize) var screenSize
  @State private var showImagePicker = false
  @State private var imageSize: CGSize = .zero
  private var imageWidth: CGFloat {
    return screenSize.width - Constants.horizantalPadding * 2
  }
  
  enum Constants {
    static let horizantalPadding: CGFloat = 92
    static let verticalPadding: CGFloat = 48
    static let totalHeight: CGFloat = 330
    static let imageHeight = totalHeight - verticalPadding * 2
  }
  
  public init(
    imageUrl: String,
    onImageSelectionCompleted: ((UIImage?) -> ())? = nil
  ) {
    self.imageUrl = imageUrl
    self.onImageSelectionCompleted = onImageSelectionCompleted
  }
  
  public var body: some View {
    VStack {
      if let _ = selectedImage {
        imageViewWithButton
      } else {
        emptyImageRegisterView
      }
    }
    .padding(.horizontal, Constants.horizantalPadding)
    .padding(.vertical, Constants.verticalPadding)
    .frame(height: Constants.totalHeight)
    .sheet(isPresented: $showImagePicker) {
      ImagePicker(selectedImage: $selectedImage)
    }
    .onChange(of: selectedImage) { oldImage, newImage in
      updateImageSize(newImage?.size ?? .zero)
      onImageSelectionCompleted?(newImage)
    }
  }
  
  private var emptyImageRegisterView: some View {
    ZStack {
      emptyBackgroundView
      imageRegisterChipView
    }
    .onTapGesture {
      showImagePicker = true
    }
  }
  
  private var emptyBackgroundView: some View {
    RoundedRectangle(cornerRadius: 20)
      .stroke(
        Color.Border.tertiary,
        lineWidth: 2,
        fill: Color.Background.assistive)
  }
  
  private var imageRegisterChipView: some View {
    HStack {
      ResourceKitAsset.Icon.album.swiftUIImage
        .resizable()
        .frame(width: 20, height: 20)
      RequiredTitleView(title: "이미지 등록")
    }
    .padding(12)
    .background {
      RoundedRectangle(cornerRadius: 25)
        .foregroundStyle(Color.Background.white)
    }
  }
  
  var imageViewWithButton: some View {
    ZStack(alignment: .bottomTrailing) {
      imageView
      imageEidtCircleView
    }
  }
  
  var imageView: some View {
    ZStack(alignment: .center) {
      RoundedRectangle(cornerRadius: 20)
        .stroke(
          Color.Border.primary,
          lineWidth: 2,
          fill: Color.Background.primary)
        .frame(width: imageWidth, height: Constants.imageHeight)
      Image(uiImage: selectedImage)
        .resizable()
        .scaledToFit()
        .frame(width: imageSize.width, height: imageSize.height)
    }
  }
  
  var kfImageViewWithButton: some View {
    ZStack(alignment: .bottomTrailing) {
      kfImageView
      imageEidtCircleView
    }
  }
  
  var imageEidtCircleView: some View {
    CircleButton(
      width: 50,
      height: 50,
      image: ResourceKitAsset.Icon.album.swiftUIImage,
      shadowColor: Color.Shadow.orange,
      action: { showImagePicker = true }
    )
    .padding(.trailing, 12)
    .padding(.bottom, 12)
  }
  
  var kfImageView: some View {
    ZStack(alignment: .center) {
      RoundedRectangle(cornerRadius: 20)
        .stroke(
          Color.Border.primary,
          lineWidth: 2,
          fill: Color.Background.primary)
      KFImage(URL(string: imageUrl))
        .resizable()
        .loadDiskFileSynchronously()
        .cacheMemoryOnly()
        .onSuccess { result in
          guard result.image.size.width > 0 else { return }
          updateImageSize(result.image.size)
        }
        .frame(width: imageSize.width, height: imageSize.height)
    }
  }
  
  func updateImageSize(_ size: CGSize) {
    let imageRatio: CGFloat
    if size.width > size.height {
      imageRatio = imageWidth / size.width
      imageSize = CGSize(
        width: imageWidth,
        height: size.height * imageRatio
      )
    } else {
      imageRatio = Constants.imageHeight / size.height
      imageSize = CGSize(
        width: size.width * imageRatio,
        height: Constants.imageHeight
      )
    }
  }
}

#Preview {
  ScrollView {
    VStack {
      // 이미지가 없을 때
      ImageEditView(imageUrl: "")
      // 가로가 긴 이미지
      ImageEditView(imageUrl: "https://png.pngtree.com/thumb_back/fh260/background/20230617/pngtree-road-and-trees-lead-to-the-mountains-image_2972647.jpg")
      // 세로가 긴 이미지
      ImageEditView(imageUrl: "https://thumb.ac-illust.com/37/37405b48206e100357550676fd124a8f_t.jpeg")
    }
  }
  
  
}
