//
//  BaseDTO.swift
//  PPACData
//
//  Created by kimchansoo on 7/6/24.
//

import Foundation

struct BaseDTO<T: Codable>: Codable {
    let status: String
    let code: Int
    let message: String
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case status
        case code
        case message
        case data
    }
}
