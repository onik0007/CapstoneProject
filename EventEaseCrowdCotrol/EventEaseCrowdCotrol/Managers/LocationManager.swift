//
//  LocationManager.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject{
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.stopUpdatingLocation()
    }
}

extension LocationManager : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else { return }
        locationManager.stopUpdatingLocation()
    }
}
