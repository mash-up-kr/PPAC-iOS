//
//  SplashView.swift
//  Home
//
//  Created by 장혜령 on 2024/07/11.
//

import SwiftUI
import ResourceKit
import PPACDomain

struct SplashView: View {
  
  // MARK: - Properties
  @ObservedObject private var viewModel: SplashViewModel
  
  // MARK: - Initializers
  
  public init(viewModel: SplashViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      ResourceKitAsset.Icon.farmemeSplashLogo.swiftUIImage
        .padding(.horizontal, 105)
      Text("내가 찾던 밈을 파밈하다")
        .font(Font.Body.Large.medium)
        .foregroundStyle(Color.Text.primary)
    }
    .opacity(viewModel.state.isVisible ? 1 : 0)
    .animation(.easeInOut(duration: 0.7), value: viewModel.state.isVisible)
  }
}

#Preview {
  SplashView(viewModel: SplashViewModel(router: nil,
                                        checkUserInfoUseCase: MockCheckUserInfoUseCase()))
}
