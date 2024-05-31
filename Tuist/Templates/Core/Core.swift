//
//  Core.swift
//  ProjectDescriptionHelpers
//
//  Created by kimchansoo on 6/1/24.
//


import ProjectDescription

let name: Template.Attribute = .required("name-core")
let author: Template.Attribute = .required("author-core")
let date: Template.Attribute = .required("current-date-core")

let CoreTemplate = Template(
    description: "Core Template",
    attributes: [
        name,
        author,
        date,
        .optional("platform", default: "ios"),
    ],
    items: [
        .file(
            path: .coreBasePath + "\(name)/" + "Project.swift",
            templatePath: "Project.stencil"
        ),
        .string(
            path: .coreBasePath + "\(name)/Sources/" + "dummy.swift",
            contents: "더미임미다"
        ),
        .string(
            path: .coreBasePath + "\(name)/Resources/" + "dummy.swift",
            contents: "더미임미다"
        ),
    ]
)

extension String {
    static var coreBasePath: Self {
        return "Projects/Core/"
    }
}

