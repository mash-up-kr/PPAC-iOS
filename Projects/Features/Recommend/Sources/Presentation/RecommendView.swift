//
//  RecommendView.swift
//  Home
//
//  Created by 장혜령 on 6/16/24.
//

import SwiftUI
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
  
  public init(
    _ viewModel: RecommendViewModel
  ) {
    self.viewModel = viewModel
    viewModel.dispatch(type: .initializeView)
  }
  
  public var body: some View {
    VStack {
      Spacer()
      RecommendHeaderView(
        userLevel: $viewModel.state.userLevel,
        seenMemeCount: $viewModel.state.memeRecommendWatchCount
      )
      
      ZStack {
        VStack {
          let isOverlapView = memeImageHeight + buttonHeight > zstackHeight
          
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
            reactionButtonTapped: {
              viewModel.dispatch(
                type: .likeButtonTapped(memeId: currentMeme?.id)
              )
            },
            copyButtonTapped: {
              viewModel.dispatch(
                type: .copyButtonTapped(memeImageUrl: currentMeme?.imageUrlString)
              )
            },
            shareButtonTapped : {
              viewModel.dispatch(
                type: .shareButtonTapped(memeImageUrl: currentMeme?.imageUrlString)
              )
            },
            saveButtonTapped : {
              viewModel.dispatch(
                type: .farmemeButtonTapped(memeId: currentMeme?.id)
              )
            }
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
    .onChange(of: currentMeme) {
      if let currentMeme {
        viewModel.dispatch(type: .showRecommendMeme(memeId: currentMeme.id))
      }
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
