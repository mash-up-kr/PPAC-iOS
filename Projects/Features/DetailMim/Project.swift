//
//  Project.swift
//  DetailMim
//
//  Created by hyeryeong on 6/24/24
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "DetailMim",
    targets: [
        .configure(
            name: "DetailMim",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [

            ]
        )
    ]
)

