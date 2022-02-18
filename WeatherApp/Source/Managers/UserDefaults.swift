//
//  UserDefaults.swift
//  WeatherApp
//
//  Created by Rezo Joglidze on 18.02.22.
//

import Foundation

extension UserDefaults {
    private class Keys {
        static let firstLaunchCompleted = "firstLaunchCompleted"
    }
    
    static var firstLaunchCompleted: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.firstLaunchCompleted) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.firstLaunchCompleted) }
    }
}
