//
//  Project.swift
//  Coordinator
//
//  Created by hyeryeong on 6/23/24
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Coordinator",
    targets: [
        .configure(
            name: "Coordinator",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [

            ]
        )
    ]
)

