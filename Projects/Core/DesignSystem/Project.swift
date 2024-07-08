//
//  Project.swift
//  Packages
//
//  Created by kimchansoo on 5/22/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "DesignSystem",
    targets: [
        .configure(
            name: "DesignSystem",
            product: .framework,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
                .ResourceKit,
                .Core.PPACModels
            ]
        )
    ]
)
