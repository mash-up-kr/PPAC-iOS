//
//  GetMemeDetailUseCase.swift
//  PPACDomain
//
//  Created by kimchansoo on 7/11/24.
//

import Foundation

import PPACModels

public protocol GetMemeDetailUseCase {
    func execute(memeId: String) async throws -> MemeDetail
}

public class GetMemeDetailUseCaseImpl: GetMemeDetailUseCase {
    private let repository: MemeRepository

    public init(repository: MemeRepository) {
        self.repository = repository
    }

    public func execute(memeId: String) async throws -> MemeDetail {
        return try await repository.getMemeDetail(memeId: memeId)
    }
}
