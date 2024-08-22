//
//  SearchResultView.swift
//  Search
//
//  Created by 리나 on 2024/06/30.
//

import SwiftUI

import PPACModels
import ResourceKit
import DesignSystem

import PopupView

public struct SearchResultView: View {
  @ObservedObject var viewModel: SearchResultViewModel
  
  public init(viewModel: SearchResultViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      Rectangle()
        .fill(Color.Background.assistive)
        .frame(maxWidth: .infinity)
        .frame(height: 1)
        .padding(.top, 51)
      
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          if viewModel.state.memeList.count > 0 {
            memeListView
          } else if viewModel.state.isLoading == false {
            emptyMemeView
          }
        }
      }
    }
    .plainNavigationBar(
      backHandler: { viewModel.dispatch(type: .naviBackButtonTapped) },
      rightActionHandler: nil,
      hasConfigureButton: false,
      title: viewModel.state.keyword
    )
    .onAppear {
      viewModel.dispatch(type: .viewWillAppear)
    }
    .popup(
      isActive: $viewModel.state.isActiveCopyPopup,
      image: ResourceKitAsset.Icon.copyFilled.swiftUIImage,
      text: "이미지를 클립보드에 복사했어요"
    )
  }
  
  private var memeListView: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("\(viewModel.state.memeList.count)개의 밈을 찾았어요")
        .font(Font.Body.Medium.medium)
        .foregroundColor(Color.Text.primary)
        .padding(.all, 20)
      
      MemeListView(
        memeDetailList: $viewModel.state.memeList,
        memeClickHandler: { meme in
          viewModel.dispatch(type: .memeDetailTapped(meme: meme))
        },
        memeCopyHandler: { meme in
          viewModel.dispatch(type: .memeCopyTapped(meme: meme))
        }
      )
      .padding(.horizontal, 20)
      
      HStack(alignment: .center) {
        Text("카페인 빨리 충전하고\n재밌는 밈 더 찾아둘게요!")
          .font(Font.Body.Large.medium)
          .foregroundColor(Color.Text.assistive)
          .multilineTextAlignment(.center)
      }
      .frame(maxWidth: .infinity)
      .frame(height: 236)
    }
  }
  
  private var emptyMemeView: some View {
    VStack(alignment: .center, spacing: 20) {
      ResourceKitAsset.Icon.emptyMeme.swiftUIImage
        .resizable()
        .frame(width: 80, height: 80)
        .padding(.top, 160)
      
      VStack(spacing: 8) {
        Text("밈이 없어요")
          .font(Font.Heading.Small.bold)
          .foregroundColor(Color.Text.primary)
        
        HStack(alignment: .center) {
          Text("카페인 빨리 충전하고\n재밌는 밈 더 찾아둘게요!")
            .font(Font.Body.Large.medium)
            .foregroundColor(Color.Text.assistive)
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
      }
    }
    .frame(maxWidth: .infinity)
  }
}
