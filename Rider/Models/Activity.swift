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
    var name: String = "New activity"
    var locations: [Location] = []
    
    init(name: String, endDate: Date? = nil, locations: [Location]) {
        self.name = name
        self.locations = locations
    }
}
