//
//  Project.swift
//  PPACAnalytics
//
//  Created by hyeryeong on 9/02/24
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "PPACAnalytics",
    targets: [
        .configure(
            name: "PPACAnalytics",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
              .ThirdParty.FirebaseAnalytics,
              .ThirdParty.FirebaseCrashlytics
            ],
            settings: .settings(
              base: [
                "OTHER_LDFLAGS": ["-all_load -Objc"]
              ]
            )
        )
    ]
)

