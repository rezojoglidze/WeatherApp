//
//  Constants.swift
//  WeatherApp
//
//  Created by Rezo Joglidze on 18.02.22.
//

import Foundation

struct Constants {
    
    struct Key {
        static let apiKey = "3e1231882b2088a822385a8d0c9a99e5"
    }
    
    struct Api {
        static let baseUrl = "https://api.openweathermap.org"
        
        struct Routes {
            static let number = "/2.5"
            static let data = "/data"
            static let weather = "/weather"
            static let lat = "lat"
            static let lon = "lon"
            static let appid = "appid"
            
            let urlStr = Constants.Api.baseUrl + Constants.Api.Routes.data + Constants.Api.Routes.number + Constants.Api.Routes.weather + "?q="  + "&appid=" + Constants.Key.apiKey
        }
    }
}
