//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by kimchansoo on 6/1/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "PPACModels",
    targets: [
        .configure(
            name: "PPACModels",
            product: .framework,
            sources: "Sources/**",
            resources: "Resources/**"
        )
    ]
)
