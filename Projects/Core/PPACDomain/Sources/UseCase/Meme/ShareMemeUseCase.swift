//
//  ShareMemeUseCase.swift
//  PPACDomain
//
//  Created by kimchansoo on 7/11/24.
//

import Foundation

import PPACModels

public protocol ShareMemeUseCase {
    func execute(memeId: String) async throws
}

public class ShareMemeUseCaseImpl: ShareMemeUseCase {
    private let repository: MemeRepository

    public init(repository: MemeRepository) {
        self.repository = repository
    }

    public func execute(memeId: String) async throws {
        try await repository.shareMeme(memeId: memeId)
    }
}
