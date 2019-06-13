//
//  NetworkConfig.swift
//  NetworkLayer
//
//  Created by José Miguel Herrero on 10/06/2019.
//  Copyright © 2019 José Miguel Herrero. All rights reserved.
//

import Foundation

struct NetworkConfig: Codable {
    let url: String
    let auth: String
    let contentType: String
    let timeout: Int
    let headerWithKey: Bool
    
    private enum CodingKeys: String, CodingKey {
        case url = "URL"
        case auth = "Authorization"
        case contentType = "Content-Type"
        case timeout = "Timeout"
        case headerWithKey = "Header with keys"
    }
}

