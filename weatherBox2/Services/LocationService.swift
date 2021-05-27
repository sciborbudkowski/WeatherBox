//
//  LocationService.swift
//  weatherBox2
//
//  Created by Ścibor Budkowski on 26/04/2021.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    
    static let instance = LocationService()
    
    private let locationManager = CLLocationManager()
    
    public func determineLocationName(completion: @escaping (CLPlacemark?) -> Void) {
        locationManager.delegate = self

        if let lastLocation = locationManager.location {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(lastLocation) { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completion(firstLocation)
                }
                else {
                    completion(nil)
                }
            }
        }
        else {
            completion(nil)
        }
    }

    public func determineLocationCoords(completion: @escaping (CLLocation?) -> Void) {
        locationManager.delegate = self
        
        if let lastLocation = locationManager.location {
            completion(lastLocation)
        }
        else {
            completion(nil)
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied, .restricted:
            debugPrint("error")
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}
