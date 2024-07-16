//
//  Project.swift
//  Packages
//
//  Created by kimchansoo on 5/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Home",
    targets: [
        .configure(
            name: "Home",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .ThirdParty.Dependency,
                .ResourceKit,
                .Core.DesignSystem,
                .Core.PPACModels,
                .Core.PPACNetwork,
                .Core.PPACData,
                .Core.PPACUtil,
                .Feature.MemeDetail,
                .Feature.Recommend,
                .Feature.MyPage,
                .Feature.Search
            ]
        )
    ]
)
