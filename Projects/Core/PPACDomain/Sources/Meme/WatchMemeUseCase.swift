//
//  WatchMemeUseCase.swift
//  PPACDomain
//
//  Created by kimchansoo on 7/11/24.
//

import Foundation

import PPACModels

public protocol WatchMemeUseCase {
    func execute(memeId: String, type: String, deviceId: String) async throws
}

public class WatchMemeUseCaseImpl: WatchMemeUseCase {
    private let repository: MemeRepository

    public init(repository: MemeRepository) {
        self.repository = repository
    }

    public func execute(memeId: String, type: String, deviceId: String) async throws {
        try await repository.watchMeme(memeId: memeId, type: type, deviceId: deviceId)
    }
}
