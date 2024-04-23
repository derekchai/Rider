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
    static let shared = LocationDataManager()
    
    private let log = Logger(subsystem: RiderApp.subsystem, category: "LocationDataManager")
    private let locationManager = CLLocationManager()
    private var updatingLocation = false
    
    var currentActivity: Activity?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    private func requestAuthorization() {
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
    
    private func startUpdatingLocation() {
        guard !updatingLocation else {
            log.notice("Attempted to start updating location but location is already being updated.")
            return
        }
        guard locationManager.authorizationStatus == .authorizedWhenInUse else {
            requestAuthorization()
            startUpdatingLocation()
            return
        }
        log.info("Starting updating location.")
        locationManager.startUpdatingLocation()
        updatingLocation = true
    }
    
    private func stopUpdatingLocation() {
        guard updatingLocation else {
            log.notice("Attempted to stop updating location but location is not being updated.")
            return
        }
        log.info("Stopping updating location.")
        locationManager.stopUpdatingLocation()
        updatingLocation = false
    }
    
    /// Create a new activity and start updating location.
    /// - Parameter name: Name of the activity.
    func startNewActivity(name: String) {
        currentActivity = nil
        guard locationManager.authorizationStatus == .authorizedWhenInUse else {
            requestAuthorization()
            return
        }
        currentActivity = Activity(name: name, locations: [])
        startUpdatingLocation()
        guard name.isNotEmpty else {
            log.info("Starting new activity.")
            return
        }
        log.info("Starting new activity \"\(name)\".")
    }
    
    /// Stop the existing activity and stop updating location.
    func stopActivity() {
        guard let currentActivity else {
            log.notice("Attempted to stop activity but no existing activity to end.")
            return
        }
        guard currentActivity.name.isNotEmpty else {
            log.info("Ending activity.")
            return
        }
        log.info("Ending activity \"\(currentActivity.name)\".")
        stopUpdatingLocation()
    }
}

extension LocationDataManager {
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestAuthorization()
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastCLLocation = locations.last else { return }
        
        log.debug("Last location: \(lastCLLocation.coordinate.latitude), \(lastCLLocation.coordinate.longitude)")
        
        guard updatingLocation, let currentActivity else { return }
        
        currentActivity.locations.append(lastCLLocation.toLocation)
    }
}
