//
//  CLLocationExtension.swift
//  Rider
//
//  Created by Derek Chai on 23/04/2024.
//

import Foundation
import CoreLocation

extension CLLocation {
    var toLocation: Location {
        Location(
            latitude: self.coordinate.latitude, 
            longitude: self.coordinate.longitude,
            altitude: self.altitude,
            speed: self.speed,
            course: self.course,
            timestamp: self.timestamp
        )
    }
}
