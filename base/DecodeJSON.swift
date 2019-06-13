//
//  DecodeJSON.swift
//  NetworkLayer
//
//  Created by José Miguel Herrero on 10/06/2019.
//  Copyright © 2019 José Miguel Herrero. All rights reserved.
//

import Foundation

class DecodeJSON {
    static let shared = DecodeJSON()
    let decoder = JSONDecoder()
    
    /// Decode raw binary Data and converted to an inferred type.
    ///
    /// - Parameter data: raw binary Data
    /// - Returns: inferred type
    public func decode<T:Codable>(data: Data?) -> T? {
        do {
            guard let data = data else { return nil }
            let result = try decoder.decode(T.self, from: data)
            print("[Decode JSON]  SUCCESS")
            
            return result
            
        } catch let error {
            print("[Decode JSON] " + error.localizedDescription)
            print("[Decode JSON] Reviewed all the keys are set correctly.")
            
            return nil
        }
    }
}
