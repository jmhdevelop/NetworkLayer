//
//  BaseService.swift
//  NetworkLayer
//
//  Created by José Miguel Herrero on 10/06/2019.
//  Copyright © 2019 José Miguel Herrero. All rights reserved.
//

import Foundation
import Alamofire

class BaseService {
    
    //Statics
    static let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(BaseService.getConfig().timeout)
        configuration.timeoutIntervalForResource = TimeInterval(BaseService.getConfig().timeout)
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        
        return sessionManager
    }()
    static let headers: HTTPHeaders = {
        var headers: HTTPHeaders = [:]
        let contentType = BaseService.getConfig().contentType
        let auth = BaseService.getConfig().auth
        
        if !contentType.isEmpty {
            headers["Content-Type"] = contentType
        }
        if !auth.isEmpty {
            headers["Authorization"] = auth
        }
        
        return headers
    }()
    
    static private func getConfig() -> NetworkConfig {
        let url = Bundle.main.url(forResource: "NetworkConfig", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(NetworkConfig.self, from: data)
    }
    
    //Privates
    fileprivate var alamoRequest: Alamofire.Request?
    
    fileprivate func urlForGetRequest(_ request: URLParams, _ url: inout String) {
        if request.petitionMethod == .get,
          let params = request.parameters?.headerParams(),
          let paramsKeys = request.parameters?.headerParamsWithKey() {
            url = (BaseService.getConfig().headerWithKey) ? url + paramsKeys : url + params
        }
    }
    
    /// Generic request for a service
    ///
    /// - Parameters:
    ///   - request: URLParams
    ///   - handle: DataResponse<Any>
    func makeRequest(request: URLParams, _ handle: @escaping (DataResponse<Any>) -> Void) {
        var url = BaseService.getConfig().url + request.path
        urlForGetRequest(request, &url)

        alamoRequest = BaseService.sessionManager.request(url,
                                                          method: request.petitionMethod,
                                                          parameters: request.parameters,
                                                          encoding: JSONEncoding.default,
                                                          headers: BaseService.headers)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                if let code = response.response?.statusCode {
                    print("[Network] URL: \(url), CODE: \(code)")
                }
                handle(response)
            })
    }
}
