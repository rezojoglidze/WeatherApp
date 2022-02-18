//
//  User.swift
//  WeatherApp
//
//  Created by Rezo Joglidze on 18.02.22.
//

import Foundation

class User {
    static var current: User?
    
    var userName: String
    var password: String
    
    init(userName: String,
         password: String) {
        self.userName = userName
        self.password = password
    }
}
