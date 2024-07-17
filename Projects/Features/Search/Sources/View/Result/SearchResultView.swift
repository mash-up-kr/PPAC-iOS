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

public struct SearchResultView: View {
  @ObservedObject var viewModel: SearchResultViewModel
  
  public init(viewModel: SearchResultViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ScrollView {
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
    .padding(.top, 51)
    .plainNavigationBar(
      backHandler: { viewModel.dispatch(type: .naviBackButtonTapped) },
      rightActionHandler: nil,
      hasConfigureButton: false,
      title: "키워드"
    )
    .onAppear {
      viewModel.dispatch(type: .viewWillAppear)
    }
  }
}
