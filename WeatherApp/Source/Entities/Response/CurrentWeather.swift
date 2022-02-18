//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Rezo Joglidze on 18.02.22.
//

import Foundation

struct CurrentWeather: Codable {
    var coord: Coordinates
    var weather: [Weather]
}

struct Weather: Codable {
    var main: String
    var description: String
}

struct Coordinates: Codable {
    var lon: Double
    var lat: Double
}
