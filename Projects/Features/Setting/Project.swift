//
//  Project.swift
//  Setting
//
//  Created by hyeryeong on 7/21/24
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Setting",
    targets: [
        .configure(
            name: "Setting",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
              .ThirdParty.Dependency,
              .ResourceKit,
              .Core.DesignSystem,
              .Core.PPACUtil,
              .Core.PPACAnalytics
            ]
        )
    ]
)

