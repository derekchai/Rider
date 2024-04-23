//
//  ActivityExtension.swift
//  Rider
//
//  Created by Derek Chai on 24/04/2024.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

extension Activity {
    var polyline: MapPolyline {
        MapPolyline(coordinates: self.locations.map { $0.toCLLocationCoordinate2D })
    }
    
    static let sampleData: [Activity] = [
        Activity(name: "Example Activity", endDate: Date.now, locations: []),
        Activity(name: "Another Activity", endDate: Date.now, locations: []),
        Activity(name: "One More Activity", endDate: Date.now, locations: [])
    ]
}
