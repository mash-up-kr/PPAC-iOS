//
//  Project.swift
//  MemeDetail
//
//  Created by kimchansoo on 2024/06/28
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "MemeDetail",
    targets: [
        .configure(
            name: "MemeDetail",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .ThirdParty.Dependency,
                .ThirdParty.Kingfisher,
                .ThirdParty.Lottie,
                .ResourceKit,
                .Core.DesignSystem,
                .Core.PPACModels,
                .Core.PPACUtil,
                .Core.PPACDomain,
                .Core.PPACData,
                .Core.PPACAnalytics
            ]
        )
    ]
)

