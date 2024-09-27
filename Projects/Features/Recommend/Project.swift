//
//  Project.swift
//  Recommend
//
//  Created by hyeryeong on 6/18/24
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: "Recommend",
  targets: [
    .configure(
      name: "Recommend",
      product: .framework,
      infoPlist: .default,
      sources: "Sources/**",
      resources: "Resources/**",
      dependencies: [
        .ThirdParty.Dependency,
        .ThirdParty.Kingfisher,
        .ThirdParty.PopupView,
        .ThirdParty.Lottie,
        .ThirdParty.SkeletonUI,
        .ResourceKit,
        .Core.DesignSystem,
        .Core.PPACModels,
        .Core.PPACDomain,
        .Core.PPACData,
        .Core.PPACUtil,
        .Core.PPACAnalytics,
        .Feature.MemeDetail,
        .Feature.MemeEditor
      ]
    )
  ]
)

