//
//  BasicResponseError.swift
//  WeatherApp
//
//  Created by Rezo Joglidze on 18.02.22.
//

import Foundation

struct BasicResponseError: Codable,Error {
    let code: Int
    let message: String
    
    init() {
        code = -1
        message = "მოხდა შეცდომა მონაცემების დამუშავებისას"
    }
}
