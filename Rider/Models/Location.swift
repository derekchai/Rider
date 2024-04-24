//
//  Location.swift
//  Rider
//
//  Created by Derek Chai on 23/04/2024.
//

import Foundation
import CoreLocation

struct Location: Codable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let altitude: CLLocationDistance
    let horizontalAccuracy: CLLocationAccuracy
    let verticalAccuracy: CLLocationAccuracy
    let speed: CLLocationSpeed
    let speedAccuracy: CLLocationSpeedAccuracy
    let course: CLLocationDirection
    let courseAccuracy: CLLocationDirectionAccuracy
    let timestamp: Date
}
