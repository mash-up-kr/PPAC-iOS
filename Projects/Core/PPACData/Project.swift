//
//  Project.swift
//  PPACData
//
//  Created by kimchansoo on 2024/07/06
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "PPACData",
    targets: [
        .configure(
            name: "PPACData",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
              .Core.PPACModels,
              .Core.PPACNetwork,
              .Core.PPACDomain,
            ]
        )
    ]
)

