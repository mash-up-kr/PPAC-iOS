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
            ]
        )
    ]
)
