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

@main
struct DemoApp: App {
	
	enum Views: String, CaseIterable, Identifiable {
		case MemeDetail
		
		var id: String { self.rawValue }
		
		var view: some View {
			switch self {
			case .MemeDetail:
				getMemeDetailView()
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
				copyImageUseCase: CopyImageUseCaseImpl(),
				postLikeUseCase: PostLikeUseCaseImpl()
			)
		)
	}
}
