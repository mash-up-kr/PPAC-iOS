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
import PPACDomain
import PPACData
import PPACNetwork

public struct MemeDetailView: View {
  
  // MARK: - Properties
  
  @ObservedObject private var viewModel: MemeDetailViewModel
  
  @State private var totalHeight: CGFloat = 0
  @State private var memeCardHeight: CGFloat = 0
  @State private var tabBarHeight: CGFloat = 0
  
  private var isShortCard: Bool {
    memeCardHeight + tabBarHeight > totalHeight - 30
  }
  
  // MARK: - Initializers
  
  public init(viewModel: MemeDetailViewModel) {
    self.viewModel = viewModel
  }
  
  // MARK: - UI
  
  public var body: some View {
    ZStack {
      VStack(spacing: 0) {
        Spacer()
        
        MemeDetailCardView(
          meme: $viewModel.state.meme,
          isShortCard: totalHeight == 0 ? false : isShortCard
        ) {
          viewModel.dispatch(type: .likeButtonTapped)
        }
        .padding(.top, 40)
        .onReadSize { size in
          if(memeCardHeight == 0) {
            memeCardHeight = size.height
          }
        }
        
        Spacer()
        
        // 가짜 탭뷰
        Rectangle()
          .frame(height: 64)
          .foregroundColor(.black.opacity(0))
          .clipShape(
            .rect(
              topLeadingRadius: 30,
              topTrailingRadius: 30
            )
          )
      }
      
      VStack(spacing: 0) {
        Spacer()

        EmptyView()
          .memeDetailTabBar(
            isFarmemed: $viewModel.state.meme.isFarmemed
          ) { tab in
            tabBarTap(tab)
          }
          .frame(maxHeight: 64)
          .onReadSize { size in
            if(tabBarHeight == 0) {
              tabBarHeight = size.height
            }
          }
      }
    }
    .onReadSize { size in
      if(totalHeight == 0) {
        totalHeight = size.height
      }
    }
    .background(
      KFImage(URL(string: viewModel.state.meme.imageUrlString))
        .resizable()
        .loadDiskFileSynchronously()
        .cacheMemoryOnly()
        .aspectRatio(contentMode: .fill)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .opacity(0.4) // Image Opacity: 40%
        .blur(radius: 50) // Layer Blur: 50
        .overlay(Color.white.opacity(0.3)) // White Dim: #fff, Opacity: 30%
        .clipped()
        .edgesIgnoringSafeArea(.top)
    )
    .onAppear {
      viewModel.logMemeDetail(interaction: .view, event: .meme)
    }
    .plainNavigationBar(
      backHandler: { viewModel.dispatch(type: .naviBackButtonTapped) },
      rightActionHandler: nil,
      hasConfigureButton: false,
      title: "밈 자세히 보기"
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

#Preview {
  let networkService = NetworkService()
  let memeRepository = MemeRepositoryImpl(networkservice: networkService)
  
  let bookmarkMemeUseCase = BookmarkMemeUseCaseImpl(repository: memeRepository)
  let watchMemeUseCase = WatchMemeUseCaseImpl(repository: memeRepository)
  let reactToMemeUseCase = ReactToMemeUseCaseImpl(repository: memeRepository)
  let shareMemeUseCase = ShareMemeUseCaseImpl(repository: memeRepository)
  
  return MemeDetailView(
    viewModel: MemeDetailViewModel(
      meme: .mock,
      router: nil,
      bookmarkMemeUseCase: bookmarkMemeUseCase,
      shareMemeUseCase: shareMemeUseCase,
      watchMemeUseCase: watchMemeUseCase,
      reactToMemeUseCase:reactToMemeUseCase
    )
  )
}
