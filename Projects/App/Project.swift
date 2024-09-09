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
              "CFBundleDisplayName": "파밈",
              "CFBundleDevelopmentRegion": "ko_KR",
              "CFBundleShortVersionString": "1.1.4",
              "CFBundleVersion": "1",
              "UILaunchStoryboardName": "launch",
              "NSUserTrackingUsageDescription": "이 앱은 사용자 맞춤형 광고 제공 및 분석을 위해 사용자 추적 정보를 수집합니다.",
              "UIUserInterfaceStyle": "Light",  // 다크모드 방지
              "NSAllowArbitraryLoads": true,
              "NSAppTransportSecurity": [
                "NSAllowsArbitraryLoads": true
              ]
          ]),
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .Feature.Home,
                .Feature.Recommend,
                .Feature.Search,
                .Feature.MyPage,
                .Feature.Setting,
                .Feature.MemeDetail,
                .ResourceKit,
                .Core.DesignSystem,
                .Core.PPACNetwork,
                .Core.PPACUtil,
                .Core.PPACAnalytics,
                .ThirdParty.Lottie,
                .ThirdParty.Dependency,
                .ThirdParty.AppsFlyerLib,
            ],
            settings: .settings(
                base: [
                    "DEVELOPMENT_TEAM": "4NV4Z6BW27",
                    "CODE_SIGN_STYLE": "Manual",
                    "PROVISIONING_PROFILE_SPECIFIER": "match AppStore ppac.farmeme.App",
                    "CODE_SIGN_IDENTITY": "Apple Distribution: Chansoo Kim (4NV4Z6BW27)",
                    "ASSOCIATED_DOMAINS": [
                        "applinks:https://farmeme.onelink.me"
                    ]
                ],
                defaultSettings: .recommended(excluding: [])
            )
        ),
        .configure(
            name: "Develop-Farmeme",
            product: .app,
            bundleId: "ppac.farmeme.App",
            infoPlist: .extendingDefault(with: [
              "CFBundleIconName": "AppIcon",
              "CFBundleDisplayName": "파밈",
              "CFBundleDevelopmentRegion": "ko_KR",
              "CFBundleShortVersionString": "1.1.4",
              "CFBundleVersion": "1",
              "UILaunchStoryboardName": "launch",
              "NSUserTrackingUsageDescription": "이 앱은 사용자 맞춤형 광고 제공 및 분석을 위해 사용자 추적 정보를 수집합니다.",
              "UIUserInterfaceStyle": "Light",  // 다크모드 방지
              "NSAppTransportSecurity": [
                "NSAllowsArbitraryLoads": true 
              ]
          ]),
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .Feature.Home,
                .Feature.Recommend,
                .Feature.Search,
                .Feature.MyPage,
                .Feature.Setting,
                .Feature.MemeDetail,
                .ResourceKit,
                .Core.DesignSystem,
                .Core.PPACNetwork,
                .Core.PPACUtil,
                .Core.PPACAnalytics,
                .ThirdParty.Dependency,
                .ThirdParty.AppsFlyerLib
            ],
            settings: .settings(
                base: [
                    "DEVELOPMENT_TEAM": "4NV4Z6BW27",
                    "CODE_SIGN_STYLE": "Manual",
                    "PROVISIONING_PROFILE_SPECIFIER": "match Development ppac.farmeme.App",
                    "CODE_SIGN_IDENTITY": "Apple Development: Chansoo Kim (T7MYKWLF92)",
                    "ASSOCIATED_DOMAINS": [
                        "applinks:https://farmeme.onelink.me"
                    ]
                ],
                defaultSettings: .recommended(excluding: [])
            )
        ),
    ]
)
