//
//  BookmarkMemeUseCase.swift
//  PPACDomain
//
//  Created by kimchansoo on 7/11/24.
//

import Foundation

import PPACModels

public protocol BookmarkMemeUseCase {
    func execute(memeId: String, deviceId: String) async throws
}

public class BookmarkMemeUseCaseImpl: BookmarkMemeUseCase {
    private let repository: MemeRepository

    public init(repository: MemeRepository) {
        self.repository = repository
    }

    public func execute(memeId: String, deviceId: String) async throws {
        try await repository.bookmarkMeme(memeId: memeId, deviceId: deviceId)
    }
}
