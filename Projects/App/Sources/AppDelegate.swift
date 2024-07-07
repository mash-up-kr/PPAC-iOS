//
//  FarmemeApp.swift
//  App
//
//  Created by kimchansoo on 6/1/24.
//  Copyright © 2024 ppac.farmeme. All rights reserved.
//

import UIKit
import Home
import MemeDetail

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	var navigationController = UINavigationController()
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		
		let router = MemeDetailRouter(navigationController, meme: .mock)
		
		self.window?.rootViewController = navigationController
		self.window?.makeKeyAndVisible()
		
		router.start() // router의 시작 메소드 호출
		
		return true
	}
}
