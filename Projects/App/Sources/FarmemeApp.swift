//
//  FarmemeApp.swift
//  App
//
//  Created by kimchansoo on 6/1/24.
//  Copyright © 2024 ppac.farmeme. All rights reserved.
//

import SwiftUI
import Home

@main
struct FarmemeApp: App {
	@State var homeCoordinator = HomeCoordinator()
	var body: some Scene {
		WindowGroup {
			HomeCoordinatorView(coordinator: homeCoordinator)
		}
	}
}
