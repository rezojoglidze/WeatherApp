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
