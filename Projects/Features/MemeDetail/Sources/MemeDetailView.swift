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
    Spacer()
    ZStack {
      memeDetailCardView
      if viewModel.state.isSheetPresented {
        Color.black.opacity(0.4)
      }
    }
    .onAppear {
      viewModel.logMemeDetail(interaction: .view, event: .meme)
    }
    .plainNavigationBar(
      backHandler: { viewModel.dispatch(type: .naviBackButtonTapped) },
      rightActionHandler: { viewModel.dispatch(type: .naviMoreButtonTapped) },
      hasConfigureButton: true,
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
    .sheet(isPresented: $viewModel.state.isSheetPresented) {
      ZStack(alignment: .bottom) {
        bottomSheetView
          .presentationDetents([.height(66)])
      }
    }
    .sheet(isPresented: $viewModel.state.isWebViewPresented) {
      WebView(url: viewModel.state.reportProblemUrl)
        .presentationDetents([.large])
    }
    Spacer()
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
  
  private var memeDetailCardView: some View {
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
            .opacity(0.4) // Image Opacity: 40%
            .blur(radius: 50) // Layer Blur: 50
            .overlay(Color.white.opacity(0.3)) // White Dim: #fff, Opacity: 30%
            .edgesIgnoringSafeArea(.top)
    )
  }
  
  private var bottomSheetView: some View {
    VStack {
      Rectangle()
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .frame(height: 16)
        .foregroundStyle(Color.Background.white)
      reportProblembutton
    }
    .onTapGesture {
      viewModel.dispatch(type: .reportProblemButtonTapped)
    }
  }
  
  private var reportProblembutton: some View {
    Text("신고하기")
      .font(Font.Body.Xlarge.medium)
      .foregroundStyle(Color.Text.primary)
      .padding(.vertical, 16)
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
