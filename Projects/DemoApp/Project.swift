//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by kimchansoo on 6/29/24.
//

import Foundation

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.configure(
    name: "DemoApp",
    packages: [
    ],
    targets: [
        .configure(
            name: "DemoApp",
            product: .app,
            bundleId: "ppac.farmeme.DemoApp",
            infoPlist: .extendingDefault(with: [
              "CFBundleShortVersionString": "1.0",
              "CFBundleVersion": "1",
              "UIMainStoryboardFile": "",
              "UILaunchStoryboardName": "LaunchScreen"
            ]),
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .Feature.Home,
                .Feature.Recommend,
                .Feature.Search,
                .Feature.MyPage,
                .ResourceKit,
                .Core.DesignSystem,
                .Core.PPACNetwork,
                .ThirdParty.Lottie,
                .ThirdParty.Dependency,
            ],
            settings: .settings(
                base: [
                    "DEVELOPMENT_TEAM": "4NV4Z6BW27",
                    "CODE_SIGN_STYLE": "Manual",
                    "PROVISIONING_PROFILE_SPECIFIER": "match AppStore ppac.farmeme.App",
                    "CODE_SIGN_IDENTITY": "Apple Distribution: Chansoo Kim (4NV4Z6BW27)"
                ]
//                defaultSettings: .recommended(excluding: [])
            )
        )
    ]
)
