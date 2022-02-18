//
//  BaseAPI.swift
//  WeatherApp
//
//  Created by Rezo Joglidze on 18.02.22.
//

import Foundation
import Network
import Alamofire
import CoreLocation

class BaseAPI {
    
    static let shared = BaseAPI()
    
    
    private func request<Parameters: Encodable>(_ convertible: URLConvertible,
                                                method: HTTPMethod = .get,
                                                parameters: Parameters? = nil,
                                                encoder: ParameterEncoder = JSONParameterEncoder(),
                                                headers: HTTPHeaders? = nil,
                                                needsAuthorization: Bool = false
    ) -> DataRequest {
        let headers: HTTPHeaders = [.init(name: "lang", value: "ka") ]
        return AF.request(convertible, method: method, parameters: parameters, encoder: encoder, headers: headers)
    }
    
    private func request(_ convertible: URLConvertible,
                         method: HTTPMethod = .get,
                         headers: HTTPHeaders? = nil,
                         needsAuthorization: Bool = false
    ) -> DataRequest {
        let headers: HTTPHeaders = [.init(name: "lang", value: "ka") ]
        return AF.request(convertible, method: method, headers: headers)
    }

    func getCurrentWeather(lat: CLLocationDegrees, lon: CLLocationDegrees, completionHandler: @escaping (Result<CurrentWeather,BasicResponseError>) -> Void) {
        let urlStr = Constants.Api.baseUrl + Constants.Api.Routes.data + Constants.Api.Routes.number + Constants.Api.Routes.weather + "?lat=" + "\(lat)" + "&lon=" + "\(lon)" + "&appid=" + "\(Constants.Key.apiKey)"
        request(urlStr, method: .get, needsAuthorization: true).responseJSON { response in
            let responseHandler = BasicResponseHandler<CurrentWeather>()
            completionHandler(responseHandler.getResult(from: response))
        }
    }
}
