//
//  MapViewModel.swift
//  WeatherApp
//
//  Created by Rezo Joglidze on 18.02.22.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa
import UIKit

protocol MapViewModelProtocol {
    
    var currentWeatherDidLoad: Observable<CurrentWeather> { get }
    
    func getCurrentWeather(lat: CLLocationDegrees, lon: CLLocationDegrees)
}

class MapViewModel {
    let currentWeatherDidLoad: Observable<CurrentWeather>
    let innerCurrentWeatherDidLoad: PublishRelay<CurrentWeather> = PublishRelay<CurrentWeather>()
    
    init() {
        self.currentWeatherDidLoad = self.innerCurrentWeatherDidLoad.asObservable()
    }
}

extension MapViewModel: MapViewModelProtocol {
    
    func getCurrentWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        BaseAPI.shared.getCurrentWeather(lat: lat, lon: lon) { [weak self] (response) in
            switch response {
            case .success(let currentWeather):
                self?.innerCurrentWeatherDidLoad.accept(currentWeather)
            case .failure(let error):
                print(error)
            }
        }
    }
}


/*
 Here is the code you're looking for, I guess:

 if let url = URL(string: UIApplicationOpenSettingsURLString) {
     if UIApplication.shared.canOpenURL(url) {
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
     }
 }
 And in addition, the updated version for swift 5 :

 if let url = URL(string: UIApplication.openSettingsURLString) {
     if UIApplication.shared.canOpenURL(url) {
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
     }
 }
 */
