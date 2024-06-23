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
//            infoPlist: .extendingDefault(with: <#T##[String : Plist.Value]#>),
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
                .Core.Coordinator,
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
        ),
        .configure(
            name: "Develop-Farmeme",
            product: .app,
            bundleId: "ppac.farmeme.App",
            infoPlist: .default,
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
                .Core.Coordinator,
                .ThirdParty.Dependency,
            ],
            settings: .settings(
                base: [
                    "DEVELOPMENT_TEAM": "4NV4Z6BW27",
                    "CODE_SIGN_STYLE": "Manual",
                    "PROVISIONING_PROFILE_SPECIFIER": "match Development ppac.farmeme.App",
                    "CODE_SIGN_IDENTITY": "Apple Development: Chansoo Kim (T7MYKWLF92)"
                ]
//                defaultSettings: .recommended(excluding: [])
            )
        ),
    ]
)
