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

public struct MemeDetailView: View {
  
  // MARK: - Properties
  
  private let viewModel: MemeDetailViewModel
  
  // MARK: - Initializers
  
  public init(viewModel: MemeDetailViewModel) {
    self.viewModel = viewModel
  }
  
  // MARK: - UI
  
  public var body: some View {
    MemeDetailCardView(meme: viewModel.state.meme) {
      viewModel.dispatch(type: .likeButtonTapped)
    }
    .padding(.horizontal, 24)
    .memeDetailTabBar { tab in
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
    .plainNavigationBar(
      backHandler: { viewModel.dispatch(type: .naviBackButtonTapped) },
      rightActionHandler: nil,
      hasConfigureButton: false,
      title: viewModel.state.meme.title
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
