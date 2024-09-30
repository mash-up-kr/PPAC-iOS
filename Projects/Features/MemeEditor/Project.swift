//
//  Project.swift
//  MemeEditor
//
//  Created by hyeryeong on 9/20/24
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "MemeEditor",
    targets: [
        .configure(
            name: "MemeEditor",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .ThirdParty.Dependency,
                .ResourceKit,
                .Core.DesignSystem,
                .Core.PPACModels,
                .Core.PPACAnalytics
            ]
        )
    ]
)

