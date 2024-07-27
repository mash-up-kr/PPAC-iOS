//
//  MemeCategorysUseCase.swift
//  PPACDomain
//
//  Created by 리나 on 7/18/24.
//

import Foundation

import PPACModels

public protocol MemeCategorysUseCase {
    func execute() async throws -> [MemeCategory]
}

public class MemeCategorysUseCaseImpl: MemeCategorysUseCase {
    private let repository: KeywordRepository

    public init(repository: KeywordRepository) {
        self.repository = repository
    }

    public func execute() async throws -> [MemeCategory] {
        try await repository.getMemeCategorys()
    }
}
