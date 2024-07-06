//
//  MemeResponseDTO.swift
//  PPACData
//
//  Created by kimchansoo on 7/6/24.
//

import Foundation

struct MemeResponseDTO: Decodable {
    let id: String
    let title: String
    let keywordIds: [String]
    let image: String
    let reaction: Int
    let source: String
    let isTodayMeme: Bool
    let isDeleted: Bool
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case keywordIds
        case image
        case reaction
        case source
        case isTodayMeme
        case isDeleted
        case createdAt
        case updatedAt
    }
}
