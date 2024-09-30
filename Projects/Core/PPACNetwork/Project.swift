//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by kimchansoo on 6/1/24.
//

import Foundation

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "PPACNetwork",
    targets: [
        .configure(
            name: "PPACNetwork",
            product: .framework,
            infoPlist: .default,
            sources: "Sources/**",
            resources: "Resources/**",
            dependencies: [
              .Core.PPACUtil,
              .ThirdParty.Alamofire
            ]
        )
    ]
)
