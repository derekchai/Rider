//
//  LocationDataManager.swift
//  Rider
//
//  Created by Derek Chai on 23/04/2024.
//

import Foundation
import CoreLocation
import OSLog

@Observable
class LocationDataManager: NSObject, CLLocationManagerDelegate {
    private let log = Logger(subsystem: RiderApp.subsystem, category: "LocationDataManager")
    
    static let shared = LocationDataManager()
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            log.info("Location authorized when in use.")
        case .notDetermined:
            log.info("Requesting location when in use authorization.")
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            log.error("Location authorization denied or restricted.")
            break
        default:
            break
        }
    }
    
    func startUpdatingLocation() {
        guard locationManager.authorizationStatus == .authorizedWhenInUse else {
            requestAuthorization()
            return
        }
        log.info("Starting updating location.")
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        log.info("Stopping updating location.")
        locationManager.stopUpdatingLocation()
    }
}

extension LocationDataManager {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        
        log.debug("Last location: \(lastLocation.coordinate.latitude), \(lastLocation.coordinate.longitude)")
    }
}
