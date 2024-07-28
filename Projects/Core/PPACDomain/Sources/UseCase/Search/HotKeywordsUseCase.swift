//
//  HotKeywordsUseCase.swift
//  PPACDomain
//
//  Created by 리나 on 7/18/24.
//

import Foundation

import PPACModels

public protocol HotKeywordsUseCase {
    func execute() async throws -> [HotKeyword]
}

public class HotKeywordsUseCaseImpl: HotKeywordsUseCase {
    private let repository: KeywordRepository

    public init(repository: KeywordRepository) {
        self.repository = repository
    }

    public func execute() async throws -> [HotKeyword] {
        try await repository.getHotKeywords()
    }
}
