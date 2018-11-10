//
//  LocationManager.swift
//  Gleam
//
//  Created by albert on 10/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import CoreLocation


class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    
    func requestAccess() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.delegate = self
        
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        UserSettings.lat = lastLocation?.coordinate.latitude
        UserSettings.lon = lastLocation?.coordinate.longitude
    }
}
