//
//  Project.swift
//  MyPage
//
//  Created by hyeryeong on 6/18/24
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "MyPage",
    targets: [
        .configure(
            name: "MyPage",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [

            ]
        )
    ]
)

