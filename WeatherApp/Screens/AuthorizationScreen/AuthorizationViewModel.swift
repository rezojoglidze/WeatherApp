//
//  AuthorizationScreenViewModel.swift
//  WeatherApp
//
//  Created by Rezo Joglidze on 18.02.22.
//

import Foundation

protocol AuthorizationViewModelProtocol {
    func authorization(username: String, password: String)
}

class AuthorizationViewModel {
    
}

extension AuthorizationViewModel: AuthorizationViewModelProtocol {
    func authorization(username: String, password: String) {
        User.current = User(userName: username, password: password)
    }
}
