//
//  Project.swift
//  Search
//
//  Created by hyeryeong on 6/18/24
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Search",
    targets: [
        .configure(
            name: "Search",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [

            ]
        )
    ]
)

