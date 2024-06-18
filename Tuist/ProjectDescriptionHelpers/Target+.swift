//
//  Target+.swift
//  ProjectDescriptionHelpers
//
//  Created by kimchansoo on 5/22/24.
//

import Foundation
import ProjectDescription

extension Target {
    
    private static let organizationName = "ppac.farmeme"
    
    public static func configure(
        name: String,
        product: Product,
//        productName: String? = nil,
        bundleId: String? = nil,
        infoPlist: InfoPlist? = .default,
        sources: SourceFilesList,
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        settings: Settings? = nil,
        environmentVariables: [String: EnvironmentVariable] = [:],
        buildRules: [BuildRule] = [],
        mergedBinaryType: MergedBinaryType = .automatic,
        mergeable: Bool = false
    ) -> Target {
        return .target(
            name: name,
            destinations: [.iPhone],
            product: product,
//            productName: productName,
            bundleId: bundleId ?? "\(organizationName).\(name)",
            deploymentTargets: .iOS("17.0"),
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            dependencies: dependencies,
            settings: settings,
            environmentVariables: environmentVariables,
            buildRules: buildRules,
            mergedBinaryType: mergedBinaryType,
            mergeable: mergeable
        )
    }
}
