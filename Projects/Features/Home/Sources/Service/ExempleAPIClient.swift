//
//  ExempleAPIClient.swift
//  Home
//
//  Created by 장혜령 on 6/9/24.
//

import Foundation
import PPACNetwork
import PPACModels

struct ExempleAPIClient: ExampleServiceable {
    
    private var apiService: Requestable
    init(apiService: Requestable) {
        self.apiService = apiService
    }
    
    func fetchExample() async throws -> ExampleDTO? {
        let request = ExampleServiceEndpoints
            .getExample
            .createRequest()
        return try? await self.apiService.request(request)
    }
    
    func postExample(id: Int) async throws -> ExampleDTO? {
        let request = ExampleServiceEndpoints
            .postExmple(id: id)
            .createRequest()
        return try? await self.apiService.request(request)
    }
    
}
