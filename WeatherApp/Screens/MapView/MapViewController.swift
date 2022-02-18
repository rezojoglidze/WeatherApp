//
//  ViewController.swift
//  WeatherApp
//
//  Created by Rezo Joglidze on 17.02.22.
//

import UIKit
import CoreLocation
import RxSwift
import MapKit

class MapViewController: UIViewController {
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var locationPermissionStatusView: UIView!
    @IBOutlet private weak var locationPermissionStatusLabel: UILabel!
    
    var viewModel: MapViewModelProtocol!
    private let locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()
    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "რუკა"
        checkIfUserHasAcceptedLocationPermission()
        setupObservables()
        setupLocationManager()
    }
    
    private func setupObservables() {
        viewModel.currentWeatherDidLoad.subscribe(onNext: { [weak self] currentWeather in
            self?.showWeatherInfoOnMap(title: currentWeather.weather.first?.main ?? "")
        }).disposed(by: disposeBag)
    }
    
    private func showWeatherInfoOnMap(title: String) {
        if let lat = latitude, let lon = longitude {
            let weaherInfo = WeatherInfo(title: title, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            mapView.addAnnotation(weaherInfo)
        }
    }
    
    private func checkIfUserHasAcceptedLocationPermission() {
        if UserDefaults.firstLaunchCompleted {
            locationPermissionStatusView.isHidden = false
            
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                locationPermissionStatusView.backgroundColor = .red
                locationPermissionStatusLabel.text = "არ არის ნებადართული"
            case .authorizedAlways, .authorizedWhenInUse:
                locationPermissionStatusLabel.text = "ნებადართულია"
            default:
                break
            }
        } else {
            UserDefaults.firstLaunchCompleted = true
        }
    }
    
    private func setupLocationManager() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func didTappLocationPermissionViewCloseBtn(_ sender: Any) {
        locationPermissionStatusView.isHidden = true
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
        mapView.centerToLocation(CLLocation(latitude: locValue.latitude, longitude: locValue.longitude))
        viewModel.getCurrentWeather(lat: locValue.latitude, lon: locValue.longitude)
    }
}

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
