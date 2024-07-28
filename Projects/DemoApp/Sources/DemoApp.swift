//
//  DemoApp.swift
//  App
//
//  Created by kimchansoo on 6/1/24.
//  Copyright © 2024 ppac.farmeme. All rights reserved.
//

import SwiftUI
import Home
import MemeDetail
import Search
import PPACDomain
import PPACNetwork
import PPACData

@main
struct DemoApp: App {
	
	enum Views: String, CaseIterable, Identifiable {
		case MemeDetail
		case SearchResult
		
		var id: String { self.rawValue }
		
		var view: AnyView {
			switch self {
			case .MemeDetail:
				AnyView(getMemeDetailView())
			case .SearchResult:
				AnyView(getSearchResultView())
			}
		}
	}
	
	@State private var selectedView: Views? = nil
	
	var body: some Scene {
		WindowGroup {
			NavigationView {
				List(Views.allCases) { view in
					NavigationLink(destination: view.view) {
						Text(view.rawValue)
					}
				}
				.navigationTitle("Views")
				.background(.blue)
			}
		}
	}
}

private extension DemoApp.Views {
	func getMemeDetailView() -> some View {
		return MemeDetailView(
			viewModel: MemeDetailViewModel(
				meme: .mock,
				router: nil,
				bookmarkMemeUseCase: BookmarkMemeUseCaseImpl(repository: MemeRepositoryImpl(networkservice: NetworkService())),
				shareMemeUseCase: ShareMemeUseCaseImpl(repository: MemeRepositoryImpl(networkservice: NetworkService())),
				watchMemeUseCase: WatchMemeUseCaseImpl(repository: MemeRepositoryImpl(networkservice: NetworkService())),
				reactToMemeUseCase: ReactToMemeUseCaseImpl(repository: MemeRepositoryImpl(networkservice: NetworkService()))
			)
		)
	}
	
	func getSearchResultView() -> some View {
		return SearchResultView(
			viewModel: SearchResultViewModel(
				keyword: "긁",
				router: nil,
				searchKeywordUseCase: SearchKeywordUseCaseImpl(
					repository: MemeRepositoryImpl(networkservice: NetworkService())
				), copyImageUseCase: CopyImageUseCaseImpl()
			)
		)
	}
}
