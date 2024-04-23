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
    let speed: CLLocationSpeed
    let course: CLLocationDirection
    let timestamp: Date
}
