//
//  MemeDetailView.swift
//  MemeDetail
//
//  Created by kimchansoo on 6/28/24.
//

import SwiftUI
import UIKit

import PPACModels
import ResourceKit
import DesignSystem

import Kingfisher
import PPACAnalytics

public struct MemeDetailView: View {
  
  // MARK: - Properties
  
  @ObservedObject private var viewModel: MemeDetailViewModel
  
  // MARK: - Initializers
  
  public init(viewModel: MemeDetailViewModel) {
    self.viewModel = viewModel
  }
  
  // MARK: - UI
  
  public var body: some View {
    MemeDetailCardView(meme: $viewModel.state.meme) {
      viewModel.dispatch(type: .likeButtonTapped)
    }
    .padding(.horizontal, 24)
    .memeDetailTabBar(isFarmemed: $viewModel.state.meme.isFarmemed) { tab in
      tabBarTap(tab)
    }
    .background(
      KFImage(URL(string: viewModel.state.meme.imageUrlString))
        .resizable()
        .loadDiskFileSynchronously()
        .cacheMemoryOnly()
        .aspectRatio(contentMode: .fill)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .clipped()
        .opacity(0.4)
        .edgesIgnoringSafeArea(.top)
    )
    .onAppear {
      viewModel.logMemeDetail(interaction: .view, event: .meme)
    }
    .plainNavigationBar(
      backHandler: { viewModel.dispatch(type: .naviBackButtonTapped) },
      rightActionHandler: nil,
      hasConfigureButton: false,
      title: viewModel.state.meme.title
    )
    .popup(
      isActive: $viewModel.state.isCopied,
      image: ResourceKitAsset.Icon.copyFilled.swiftUIImage,
      text: "이미지를 클립보드에 복사했어요"
    )
    .popup(
      isActive: $viewModel.state.isFarmemeChanged,
      image: viewModel.state.meme.isFarmemed ? ResourceKitAsset.Icon.copyFilled.swiftUIImage : nil,
      text: viewModel.state.meme.isFarmemed ? "파밈 완료!" : "파밈을 취소했어요"
    )
  }
  
  @MainActor
  private func tabBarTap(_ type: MemeDetailTab) {
    switch type {
    case .copy:
      viewModel.dispatch(type: .copyButtonTapped)
    case .farmeme:
      viewModel.dispatch(type: .farmemeButtonTapped)
    case .share:
      viewModel.dispatch(type: .shreButtonTapped)
    }
  }
}
//
//#Preview {
//  MemeDetailView(
//    viewModel: MemeDetailViewModel(
//      meme: .mock,
//      router: nil,
//      postLikeUseCase: MockPostLikeUseCase()
//    )
//  )
//}
