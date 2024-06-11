//
//  Project.swift
//  PPACUtil
//
//  Created by kimchansoo on 2024/06/09
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "PPACUtil",
    targets: [
        .configure(
            name: "PPACUtil",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [

            ]
        )
    ]
)

