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
        Location(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude, altitude: self.altitude, horizontalAccuracy: self.horizontalAccuracy, verticalAccuracy: self.verticalAccuracy, speed: self.speed, speedAccuracy: self.speedAccuracy, course: self.course, courseAccuracy: self.courseAccuracy, timestamp: self.timestamp)
    }
}
