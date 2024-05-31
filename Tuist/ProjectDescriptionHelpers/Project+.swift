//
//  Project+.swift
//  ProjectDescriptionHelpers
//
//  Created by kimchansoo on 5/22/24.
//

import ProjectDescription

extension Project {
    
    private static let organizationName = "ppac.farmeme"
    
    public static func configure(
        name: String,
        options: Options? = nil,
        packages: [Package] = [],
//        settings: Settings? = nil,
        targets: [Target] = [],
        schemes: [Scheme] = []
    ) -> Project {
        return Project(
            name: name,
            organizationName: organizationName,
            options: .options(
                automaticSchemesOptions: .enabled(
                    targetSchemesGrouping: .singleScheme,
                    codeCoverageEnabled: true,
                    testingOptions: .parallelizable
                ),
                developmentRegion: "ko",
                textSettings: .textSettings(
                    usesTabs: true,
                    indentWidth: 2,
                    tabWidth: 2,
                    wrapsLines: true
                )
            ),
            packages: packages,
            settings: .settings(
                base: [
                    "ONLY_ACTIVE_ARCH": "YES"
                ],
//                configurations: [
//                    .debug(name: "debug"),
//                    .release(name: "release")
//                ],
                defaultSettings: .recommended(
                    excluding: []
                )
            ),
            targets: targets,
            schemes: schemes,
            resourceSynthesizers: .default
        )
    }
}
