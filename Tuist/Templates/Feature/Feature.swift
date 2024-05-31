//
//  Feature.swift
//  ProjectDescriptionHelpers
//
//  Created by kimchansoo on 6/1/24.
//

import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")
let authorAttribute: Template.Attribute = .required("author")
let dateAttribute: Template.Attribute = .required("current-date")

let FeatureTemplate = Template(
    description: "Feature Template",
    attributes: [
        nameAttribute,
        authorAttribute,
        dateAttribute,
        .optional("platform", default: "ios"),
    ],
    items: [
        .file(
            path: .featureBasePath + "\(nameAttribute)/" + "Project.swift",
            templatePath: "Project.stencil"
        ),
        .string(
            path: .featureBasePath + "\(nameAttribute)/Sources/" + "dummy.swift",
            contents: "더미임미다"
        ),
        .string(
            path: .featureBasePath + "\(nameAttribute)/Resources/" + "dummy.swift",
            contents: "더미임미다"
        ),
    ]
)

extension String {
    static var featureBasePath: Self {
        return "Projects/Features/"
    }
}
