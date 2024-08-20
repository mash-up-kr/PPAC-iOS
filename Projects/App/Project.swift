//
//  Project.swift
//  Packages
//
//  Created by kimchansoo on 5/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.configure(
    name: "App",
    packages: [
    ],
    targets: [
        .configure(
            name: "Release-Farmeme",
            product: .app,
            bundleId: "ppac.farmeme.App",
            infoPlist: .extendingDefault(with: [
              "CFBundleIconName": "AppIcon",
              "CFBundleDevelopmentRegion": "ko_KR",
              "CFBundleShortVersionString": "1.1.1",
              "CFBundleVersion": "1",
              "UILaunchStoryboardName": "launch",
              "UIUserInterfaceStyle": "Light"  // 다크모드 방지
          ]),
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .Feature.Home,
                .Feature.Recommend,
                .Feature.Search,
                .Feature.MyPage,
                .Feature.Setting,
                .ResourceKit,
                .Core.DesignSystem,
                .Core.PPACNetwork,
                .Core.PPACUtil,
                .ThirdParty.Lottie,
                .ThirdParty.Dependency,
                .ThirdParty.FirebaseAnalytics,
                .ThirdParty.FirebaseCrashlytics
            ],
            settings: .settings(
                base: [
                    "DEVELOPMENT_TEAM": "4NV4Z6BW27",
                    "CODE_SIGN_STYLE": "Manual",
                    "PROVISIONING_PROFILE_SPECIFIER": "match AppStore ppac.farmeme.App",
                    "CODE_SIGN_IDENTITY": "Apple Distribution: Chansoo Kim (4NV4Z6BW27)"
                ],
                defaultSettings: .recommended(excluding: [])
            )
        ),
        .configure(
            name: "Develop-Farmeme",
            product: .app,
            bundleId: "ppac.farmeme.App",
            infoPlist: .extendingDefault(with: [
              "UILaunchStoryboardName": "launch",
              "UIUserInterfaceStyle": "Light"  // 다크모드 방지
          ]),
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .Feature.Home,
                .Feature.Recommend,
                .Feature.Search,
                .Feature.MyPage,
                .Feature.Setting,
                .ResourceKit,
                .Core.DesignSystem,
                .Core.PPACNetwork,
                .Core.PPACUtil,
                .ThirdParty.Dependency,
                .ThirdParty.FirebaseAnalytics,
                .ThirdParty.FirebaseCrashlytics
            ],
            settings: .settings(
                base: [
                    "DEVELOPMENT_TEAM": "4NV4Z6BW27",
                    "CODE_SIGN_STYLE": "Manual",
                    "PROVISIONING_PROFILE_SPECIFIER": "match Development ppac.farmeme.App",
                    "CODE_SIGN_IDENTITY": "Apple Development: Chansoo Kim (T7MYKWLF92)"
                ],
                defaultSettings: .recommended(excluding: [])
            )
        ),
    ]
)
