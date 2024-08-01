//
//  RecommendView.swift
//  Home
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI
import PopupView

import ResourceKit

import PPACModels
import PPACDomain
import PPACData
import PPACNetwork
import DesignSystem

public struct RecommendView: View {
  
  @ObservedObject private var viewModel: RecommendViewModel
  
  @State private var memeImageHeight: CGFloat = 0
  @State private var zstackHeight: CGFloat = 0
  @State private var buttonHeight: CGFloat = 0
  @State private var currentMeme: MemeDetail?
  
  @State var isActiveCopyPopup: Bool = false
  
  @State var isFarmemed: Bool = false
  @State var isActiveFarmemePopup: Bool = false
  
  @State private var currentOffsetY: CGFloat = 0
  
  public init(
    _ viewModel: RecommendViewModel
  ) {
    self.viewModel = viewModel
    viewModel.dispatch(type: .viewInitialized)
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      Spacer()
      
      if viewModel.state.recommendMemeSize > 0 &&
          !viewModel.state.isSuccessFetch
      {
        ProgressView()
          .frame(width: 30, height: 30, alignment: .center)
          .padding(.bottom, 20)
      }
      
      RecommendHeaderView(
        userLevel: $viewModel.state.userLevel,
        seenMemeCount: $viewModel.state.memeRecommendWatchCount,
        recommendMemeSize: $viewModel.state.recommendMemeSize
      )
      
      ZStack {
        VStack {
          let isOverlapView = memeImageHeight + buttonHeight > zstackHeight + 30
          
          if viewModel.state.recommendMemes.count > 0 {
            RecommendMemeImagesView(
              currentMeme: $currentMeme,
              memes: viewModel.state.recommendMemes,
              isTagHidden: isOverlapView
            )
            .onReadSize { size in
              memeImageHeight = size.height
            }
          }
          
          Spacer()
        }
        .zIndex(1)
        
        VStack {
          Spacer()
          
          RecommendMemeButtonView(
            meme: $currentMeme,
            reactionButtonTapped: reactionButtonTap,
            copyButtonTapped: copyButtonTap,
            shareButtonTapped : shareButtonTap,
            saveButtonTapped : saveButtonTap
          )
          .onReadSize { size in
            buttonHeight = size.height
          }
        }
        .zIndex(2)
      }
      .onReadSize { size in
        zstackHeight = size.height
      }
      
      Spacer(minLength: 98)
    }
    .offset(y: currentOffsetY)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      LinearGradient(
        colors: [
          Color.Background.brandassistive,
          Color.Background.brandsubassistive
        ],
        startPoint: .top,
        endPoint: .bottom
      )
    )
    .edgesIgnoringSafeArea(.bottom)
    .onChange(of: viewModel.state.isSuccessFetch) {
      withAnimation(.spring()) {
        currentOffsetY = viewModel.state.isSuccessFetch ? .zero : 20
      }
    }
    .onChange(of: currentMeme) {
      if let currentMeme {
        viewModel.dispatch(type: .showRecommendMeme(memeId: currentMeme.id))
      }
    }
    .popup(
      isActive: $isActiveCopyPopup,
      image: ResourceKitAsset.Icon.copyFilled.swiftUIImage,
      text: "이미지를 클립보드에 복사했어요"
    )
    .popup(
      isActive: $isActiveFarmemePopup,
      image: isFarmemed ? ResourceKitAsset.Icon.copyFilled.swiftUIImage : nil,
      text: isFarmemed ? "파밈 완료!" : "파밈을 취소했어요"
    )
    .gesture(
      DragGesture()
        .onChanged({ value in
          if viewModel.state.recommendMemes.isEmpty { return }
          
          if value.translation.height < 0 { return }
          
          withAnimation(.spring()) {
            currentOffsetY = value.translation.height > 180 ? 180 : value.translation.height
          }
        })
        .onEnded({ value in
          if viewModel.state.recommendMemes.isEmpty { return }
          
          if value.translation.height > 160 {
            viewModel.state.isSuccessFetch = false
            viewModel.dispatch(type: .viewInitialized)
          } else {
            withAnimation(.spring()) {
              currentOffsetY = .zero
            }
          }
        })
    )
  }
  
  private func reactionButtonTap() {
    viewModel.dispatch(
      type: .likeButtonTapped(memeId: currentMeme?.id)
    )
  }
  
  private func copyButtonTap() {
    if isActiveCopyPopup || isActiveFarmemePopup { return }
    viewModel.dispatch(
      type: .copyButtonTapped(memeImageUrl: currentMeme?.imageUrlString)
    )
    isActiveCopyPopup = true
  }
  
  private func shareButtonTap() {
    viewModel.dispatch(
      type: .shareButtonTapped(memeImageUrl: currentMeme?.imageUrlString)
    )
  }
  
  private func saveButtonTap() {
    if isActiveCopyPopup || isActiveFarmemePopup { return }
    viewModel.dispatch(
      type: .farmemeButtonTapped(memeId: currentMeme?.id)
    )
    currentMeme?.isFarmemed.toggle()
    isActiveFarmemePopup = true
    if let currentMeme {
      isFarmemed = currentMeme.isFarmemed
    }
  }
}

#Preview {
  var selectedTab: MainTab = .recommend
  
  var selectedTabBinding: Binding<MainTab> {
    Binding(
      get: { selectedTab },
      set: { selectedTab = $0 }
    )
  }
  
  let networkService = NetworkService()
  let memeRepository = MemeRepositoryImpl(networkservice: networkService)
  let userRepository = UserRepositoryImpl(networkservice: networkService)
  let getRecommendMemesUseCase = GetRecommendMemesUseCaseImpl(
    repository: memeRepository
  )
  let getUserInfoUseCase = GetUserInfoUseCaseImpl(userRepository: userRepository)
  let watchMemeUseCase = WatchMemeUseCaseImpl(repository: memeRepository)
  let reactToMemeUseCase = ReactToMemeUseCaseImpl(repository: memeRepository)
  let bookmarkMemeUseCase = BookmarkMemeUseCaseImpl(repository: memeRepository)
  
  return RecommendView(
    RecommendViewModel(
      router: nil,
      getRecommendMemesUseCase: getRecommendMemesUseCase,
      getUserInfoUseCase: getUserInfoUseCase,
      watchMemeUseCase: watchMemeUseCase,
      reactToMemeUseCase: reactToMemeUseCase,
      bookmarkMemeUseCase: bookmarkMemeUseCase
    )
  )
  .tabBar(selectedTab: selectedTabBinding)
}
