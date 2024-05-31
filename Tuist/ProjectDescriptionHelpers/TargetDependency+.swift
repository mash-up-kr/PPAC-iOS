//
//  TargetDependency+.swift
//  Packages
//
//  Created by kimchansoo on 5/22/24.
//

import Foundation
import ProjectDescription

extension TargetDependency {
    
    public struct Feature {
        public static let Home = project(moduleName: "Home")
    }
    
    public struct Core {
        public static let DesignSystem = project(moduleName: "DesignSystem")
        public static let PPACModels = project(moduleName: "PPACModels")
    }
    
    public struct ThirdParty {
        public static let Lottie = TargetDependency.external(name: "Lottie")
        public static let Dependency = TargetDependency.external(name: "Dependencies")
    }
    
    public static let ResourceKit = TargetDependency.project(
        target: "ResourceKit",
        path: .relativeToRoot("Projects/ResourceKit")
    )
}

extension TargetDependency.Feature {
    static func project(moduleName: String) -> TargetDependency {
        return .project(
            target: moduleName,
            path: .relativeToRoot("Projects/Features/\(moduleName)")
        )
    }
}

extension TargetDependency.Core {
    static func project(moduleName: String) -> TargetDependency {
        return .project(
            target: moduleName,
            path: .relativeToRoot("Projects/Core/\(moduleName)")
        )
    }
}
