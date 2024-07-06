//
//  Project.swift
//  PPACDomain
//
//  Created by kimchansoo on 2024/07/06
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "PPACDomain",
    targets: [
        .configure(
            name: "PPACDomain",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
              .Core.PPACModels,
            ]
        )
    ]
)

