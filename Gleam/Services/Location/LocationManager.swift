//
//  LocationManager.swift
//  Gleam
//
//  Created by albert on 10/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func locationManagerDidChangeRequestStatus(_ locationManager: LocationManager, enable: Bool)
    func locationManagerDidChangeCoordinates(_ locationManager: LocationManager)
}

class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    func requestAccess() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.delegate = self
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            delegate?.locationManagerDidChangeRequestStatus(self, enable: false)
        default:
            locationManager.startUpdatingLocation()
            delegate?.locationManagerDidChangeRequestStatus(self, enable: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        UserSettings.lat = lastLocation?.coordinate.latitude ?? 0
        UserSettings.lon = lastLocation?.coordinate.longitude ?? 0
        delegate?.locationManagerDidChangeCoordinates(self)
    }
}
