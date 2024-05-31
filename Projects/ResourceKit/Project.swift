//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by kimchansoo on 6/1/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.configure(
    name: "ResourceKit",
    packages: [
    ],
    targets: [
        .configure(
            name: "ResourceKit",
            product: .framework,
//            infoPlist: .extendingDefault(with: <#T##[String : Plist.Value]#>),
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
            ]
        )
    ]
)
