//
//  OpenWeatherService.swift
//  weatherBox2
//
//  Created by Ścibor Budkowski on 26/04/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit

enum DayPart {
    case day
    case night
}

class OpenWeatherService {
    
    public func getForecast(_ coordinate: CLLocation, completion: @escaping(OpenWeather?, Error?) -> Void) {
        let url = "\(API_OPENWEATHER_ORG)onecall?&lat=\(coordinate.coordinate.latitude)&lon=\(coordinate.coordinate.longitude)&exclude=minutely&units=metric&appid=\(API_OPENWEATHER_ORG_APP_ID)"
        let request = AF.request(URL(string: url)!)
        
        request.responseDecodable(of: OpenWeather.self) { (response) in
            guard let result = response.value else {
                completion(nil, response.error)
                print("getForecast: \(String(describing: response.error))")
                return
            }
            
            completion(result, nil)
        }
    }
    
    public func getAirQuality(_ coordinate: CLLocation, completion: @escaping(AirQuality?, Error?) -> Void) {
        let url = "\(API_OPENWEATHER_ORG)air_pollution?lat=\(coordinate.coordinate.latitude)&lon=\(coordinate.coordinate.longitude)&appid=\(API_OPENWEATHER_ORG_APP_ID)"
        let request = AF.request(URL(string: url)!)
        
        request.responseDecodable(of: AirQuality.self) { (response) in
            guard let result = response.value else {
                completion(nil, response.error)
                print("getAirQuality: \(String(describing: response.error))")
                return
            }
            
            completion(result, nil)
        }
    }
    
    public static func getWindSpeedType(for speed: Float) -> WindSpeed? {
        let type = windTypes.map( { (type) -> WindSpeed? in
            if speed >= type.minMetric && speed <= type.maxMetric {
                return type
            }
            
            return nil
        }).first!
        
        return type
    }
    
    public static func getDayPart(for timestamp: Int, sunrise: Int, sunset: Int) -> DayPart {
        if timestamp > sunrise, timestamp < sunset {
            return .day
        }
        
        return .night
    }
}
