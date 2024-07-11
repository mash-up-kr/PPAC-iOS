//
//  SplashView.swift
//  Home
//
//  Created by 장혜령 on 2024/07/11.
//

import SwiftUI
import ResourceKit
import Combine

struct SplashView: View {
  
  // MARK: - Properties
  @ObservedObject private var viewModel: SplashViewModel
  @State private var cancleable = Set<AnyCancellable>()
  // MARK: - Initializers
  
  public init(viewModel: SplashViewModel) {
    self.viewModel = viewModel
    self.bindViewModel()
  }
  
  private func bindViewModel() {
    viewModel.$state
      .receive(on: RunLoop.main)
      .sink { _ in
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
          print("호출이 왜 안되나!!!!!!!!")
          viewModel.dispatch(type: .finishSplash)
        }
      }
      .store(in: &cancleable)
  }
  
  var body: some View {
    VStack {
      ResourceKitAsset.Icon.farmemeSplashLogo.swiftUIImage
        .padding(.horizontal, 105)
      Text("내가 찾던 밈을 파밈하다")
        .font(Font.Body.Large.medium)
        .foregroundStyle(Color.Text.primary)
    }
    .opacity(viewModel.isVisible ? 1 : 0)
    .animation(.easeInOut(duration: 3.0), value: viewModel.isVisible)
    .onAppear {
      viewModel.dispatch(type: .startSplash)
    }
  }
  
}

#Preview {
  SplashView(viewModel: SplashViewModel(router: nil,
                                        createUserUserCase: MockCreateUserUseCase()))
}
