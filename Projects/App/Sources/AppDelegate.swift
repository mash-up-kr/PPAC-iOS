//
//  FarmemeApp.swift
//  App
//
//  Created by kimchansoo on 6/1/24.
//  Copyright © 2024 ppac.farmeme. All rights reserved.
//

import UIKit
import SwiftUI
import Home
import PPACUtil
import FirebaseCore

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	var navigationController = UINavigationController()
	var appRouter: Router?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
		FirebaseApp.configure()
		
		self.window = UIWindow(frame: UIScreen.main.bounds)
		let router = SplashRouter(navigationController)
		self.navigationController.setNavigationBarHidden(true, animated: false)
		self.appRouter = router
		self.window?.rootViewController = navigationController
		self.window?.makeKeyAndVisible()
		router.start() // router의 시작 메소드 호출
		return true
	}
}
