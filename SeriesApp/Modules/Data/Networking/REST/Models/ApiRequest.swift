//
//  ApiRequest.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/16/21.
//

import Foundation

class ApiRequest {
    
    let resource: URL
    let method: HttpMethod
    let expectedCode: Int
    let header: [String: String]?
    let json: Data?
    
    init(resource: URL,
         method: HttpMethod = .get,
         expectedCode: Int = 200,
         header: [String: String]? = nil,
         json: Data? = nil) {
        
        self.resource = resource
        self.method = method
        self.expectedCode = expectedCode
        self.header = header
        self.json = json
    }
}
