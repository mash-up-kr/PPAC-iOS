//
//  GetRecommendMemesUseCase.swift
//  PPACDomain
//
//  Created by kimchansoo on 7/11/24.
//

import Foundation

import PPACModels

public protocol GetRecommendMemesUseCase {
    func execute(size: Int) async throws -> [MemeDetail]
}

public class GetRecommendMemesUseCaseImpl: GetRecommendMemesUseCase {
    private let repository: MemeRepository

    public init(repository: MemeRepository) {
        self.repository = repository
    }

    public func execute(size: Int) async throws -> [MemeDetail] {
        return try await repository.getRecommendMemes(size: size)
    }
}
