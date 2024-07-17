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

public struct RecommendView: View {
  
  @ObservedObject private var viewModel: RecommendViewModel
  
  @State private var memeImageHeight: CGFloat = 0
  @State private var zstackHeight: CGFloat = 0
  @State private var buttonHeight: CGFloat = 0
  
  @State private var currentViewingMemeId: String?
  @State private var currentViewingMemeReaction: Int?
  
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
              currentViewingMemeId: $currentViewingMemeId,
              currentViewingMemeReaction: $currentViewingMemeReaction,
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
            reactionCount: $currentViewingMemeReaction,
            reactionButtonTapped: {
              viewModel.dispatch(
                type: .likeButtonTapped(memeId: currentViewingMemeId)
              )
            },
            copyButtonTapped: {
              viewModel.dispatch(
                type: .copyButtonTapped(memeId: currentViewingMemeId)
              )
            },
            shareButtonTapped : {
              viewModel.dispatch(
                type: .shareButtonTapped(memeId: currentViewingMemeId)
              )
            },
            saveButtonTapped : {
              viewModel.dispatch(
                type: .farmemeButtonTapped(memeId: currentViewingMemeId)
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
  }
}

#Preview {
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
}
