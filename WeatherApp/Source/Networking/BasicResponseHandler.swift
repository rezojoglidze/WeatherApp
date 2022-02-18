//
//  BasicResponseHandler.swift
//  WeatherApp
//
//  Created by Rezo Joglidze on 18.02.22.
//

import Foundation
import Alamofire

class BasicResponseHandler<T: Decodable> {
    
    func getResult(from response: AFDataResponse<Any>) -> Result<T,BasicResponseError> {
        if let httpStatusCode = response.response?.statusCode {
            if httpStatusCode == 401 {
                return .failure(BasicResponseError())
            } else if let data = response.data {
                if httpStatusCode == 200 {
                    do {
                        let responseBody = try JSONDecoder().decode(T.self, from: data)
                        return .success(responseBody)
                    } catch {
                        printOutDataForParsingError(response: response, error: error)
                        return .failure(BasicResponseError())
                    }
                }
                else if httpStatusCode == 400 {
                    do {
                        let basicResponseError = try JSONDecoder().decode(BasicResponseError.self, from: data)
                        return .failure(basicResponseError)
                    } catch {
                        printOutDataForParsingError(response: response, error: error)
                        return .failure(BasicResponseError())
                    }
                } else {
                    return .failure(BasicResponseError())
                }
            } else {
                return .failure(BasicResponseError())
            }
        } else {
            return .failure(BasicResponseError())
        }
    }
    
    func printOutDataForParsingError(response: AFDataResponse<Any>,error: Error) {
        guard let urlString = response.request?.url?.absoluteString else { return }
        print("URL: \(urlString) \n Error: \(error)")
    }
    
    
}

class EmptyResponseHandler {
    
    func getResult(from response: AFDataResponse<Any>) -> Result<Bool,BasicResponseError> {
        if let httpStatusCode = response.response?.statusCode {
            if httpStatusCode == 200 {
                return .success(true)
            } else if let data = response.data, httpStatusCode == 400 {
                do {
                    let basicResponseError = try JSONDecoder().decode(BasicResponseError.self, from: data)
                    return .failure(basicResponseError)
                } catch {
                    printOutDataForParsingError(response: response, error: error)
                    return .failure(BasicResponseError())
                }
            } else {
                return .failure(BasicResponseError())
            }
        } else {
            return .failure(BasicResponseError())
        }
    }
    
    func printOutDataForParsingError(response: AFDataResponse<Any>,error: Error) {
        guard let urlString = response.request?.url?.absoluteString else { return }
        print("URL: \(urlString) \n Error: \(error)")
    }
}
