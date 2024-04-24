//
//  LocationExtension.swift
//  Rider
//
//  Created by Derek Chai on 24/04/2024.
//

import Foundation
import CoreLocation

extension Location {
    /// Returns the `CLLocationCoordinate2D` from this `Location`.
    var toCLLocationCoordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    var toCLLocation: CLLocation {
        CLLocation(
            coordinate: self.toCLLocationCoordinate2D,
            altitude: self.altitude,
            horizontalAccuracy: self.horizontalAccuracy,
            verticalAccuracy: self.verticalAccuracy,
            course: self.course,
            courseAccuracy: self.courseAccuracy,
            speed: self.speed,
            speedAccuracy: self.speedAccuracy,
            timestamp: self.timestamp
        )
    }
}
