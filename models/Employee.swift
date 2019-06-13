//
//  Employee.swift
//  NetworkLayer
//
//  Created by José Miguel Herrero on 10/06/2019.
//  Copyright © 2019 José Miguel Herrero. All rights reserved.
//

import Foundation

struct Employee: Codable {
    let id: Int
    let name: String
    let salary: Int
    let age: Int
    let image: String
}
