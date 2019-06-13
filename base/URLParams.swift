//
//  URLParams.swift
//  NetworkLayer
//
//  Created by José Miguel Herrero on 10/06/2019.
//  Copyright © 2019 José Miguel Herrero. All rights reserved.
//

import Foundation
import Alamofire

class URLParams {
    
    var path: String
    var petitionMethod: HTTPMethod
    var parameters: Parameters?
    
    init(path: String, petition: HTTPMethod, params: Parameters?) {
        self.path = path
        self.petitionMethod = petition
        self.parameters = params
    }
    
}

// Extension Parameters
extension Parameters {
    func headerParamsWithKey() -> String {
        var stringParams = ""
        for param in self {
            stringParams = stringParams + "?\(param.key)=\(param.value)"
        }
        
        return stringParams
    }
    func headerParams() -> String {
        var stringParams = ""
        for param in self {
            stringParams = stringParams + "/\(param.value)"
        }
        
        return stringParams
    }
}
