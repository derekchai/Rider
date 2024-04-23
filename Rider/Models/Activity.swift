//
//  Item.swift
//  Rider
//
//  Created by Derek Chai on 23/04/2024.
//

import Foundation
import SwiftData
import CoreLocation

@Model
final class Activity {
    var name: String = ""
    var endDate: Date
    var coordinates: [CLLocationCoordinate2D] = []
    
    init(name: String, endDate: Date, points: [CLLocationCoordinate2D]) {
        self.name = name
        self.endDate = endDate
        self.coordinates = points
    }
}
