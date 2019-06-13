//
//  ApiClient.swift
//  NetworkLayer
//
//  Created by José Miguel Herrero on 10/06/2019.
//  Copyright © 2019 José Miguel Herrero. All rights reserved.
//

import Foundation
import Alamofire

class ApiClient {
    static let shared = ApiClient()
    private let service = BaseService.init()
    
    /// To get and array of employees
    ///
    /// - Parameter handle: return Result<[Employee]>
    func getEmployees(_ handle: @escaping (Result<[Employee]>) -> Void) {
        let request = URLParams(path: "employees",
                                petition: .get,
                                params: [:])
        
        service.makeRequest(request: request) { (response) in
            switch response.result {
            case .success(_):
                guard let employee: [Employee] = DecodeJSON.shared.decode(data: response.data) else { return }
                handle(.success(employee))
                
            case .failure(let error):
                handle(.failure(error))
            }
        }
    }
    
    /// To get a employee
    ///
    /// - Parameters:
    ///   - id: id of a employee
    ///   - handle: return Result<[Employee]>
    func getEmployee(id: Int, _ handle: @escaping (Result<[Employee]>) -> Void) {
        let request = URLParams(path: "employees",
                                petition: .get,
                                params: ["id" : id])
        
        service.makeRequest(request: request) { (response) in
            switch response.result {
            case .success(_):
                guard let employee: [Employee] = DecodeJSON.shared.decode(data: response.data) else { return }
                handle(.success(employee))
                
            case .failure(let error):
                handle(.failure(error))
            }
        }
    }
    
    
    /// To created a employee on the db
    ///
    /// - Parameters:
    ///   - params: params needed to create a employee
    ///   - handle: Result<Employee>
    func createEmployee(params: Parameters, _ handle: @escaping (Result<Employee>) -> Void) {
        let request = URLParams(path: "employees",
                                petition: .put,
                                params: params)
        
        service.makeRequest(request: request) { (response) in
            switch response.result {
            case .success(_):
                guard let employee: Employee = DecodeJSON.shared.decode(data: response.data) else { return }
                handle(.success(employee))
                
            case .failure(let error):
                handle(.failure(error))
            }
        }
    }
}
