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
    /// Returns the `Date` the `Activity` started.
    var dateStarted: Date? {
        self.locations.map { $0.timestamp }.min()
    }
    
    /// Returns the `Date` the `Activity` stopped.
    var dateStopped: Date? {
        self.locations.map { $0.timestamp }.max()
    }
    
    /// Returns the total distance of the `Activity`, in metres.
    var distance: CLLocationDistance {
        var distance = 0.0
        for i in 0..<(self.locations.count - 1) {
            distance += self.locations[i].toCLLocation.distance(from: self.locations[i + 1].toCLLocation)
        }
        return distance
    }
    
    /// Returns the total duration of the `Activity` in seconds.
    ///
    /// If the activity's array of `Location`s is empty, returns `-1`.
    var duration: TimeInterval {
        guard self.locations.isNotEmpty else { return -1 }
        let timeIntervalsSince1970 = self.locations.map { $0.timestamp.timeIntervalSince1970 }
        return timeIntervalsSince1970.max()! - timeIntervalsSince1970.min()!
    }
    
    /// Returns the minimum speed of the `Activity`, in metres per second.
    ///
    /// If the activity's array of `Location`s is empty, returns `-1`.
    var minSpeed: CLLocationSpeed {
        guard self.locations.isNotEmpty else { return -1 }
        return self.locations.map { $0.speed }.min()!
    }
    
    /// Returns the maximum speed of the `Activity`, in metres per second.
    ///
    /// If the activity's array of `Location`s is empty, returns `-1`.
    var maxSpeed: CLLocationSpeed {
        guard self.locations.isNotEmpty else { return -1 }
        return self.locations.map { $0.speed }.max()!
    }
    
    /// Returns the minimum altitude of the `Activity`, in metres.
    ///
    /// If the activity's array of `Location`s is empty, returns `nil`.
    var minAltitude: CLLocationDistance? {
        return self.locations.map { $0.altitude }.min()
    }
    
    /// Returns the maximum altitude of the `Activity`, in metres.
    ///
    /// If the activity's array of `Location`s is empty, returns `nil`.
    var maxAltitude: CLLocationDistance? {
        return self.locations.map { $0.altitude }.max()
    }
    
    /// Returns the altitude gained during the `Activity`, in metres.
    ///
    /// If the activity's array of `Location`s is empty, returns `nil`.
    var altitudeAscended: CLLocationDistance? {
        var altitudeGained = 0.0
        for i in 0..<(self.locations.count - 1) {
            guard self.locations[i].altitude < self.locations[i + 1].altitude else { continue }
            altitudeGained += self.locations[i + 1].altitude - self.locations[i].altitude
        }
        return altitudeGained
    }
    
    /// Returns the altitude lost during the `Activity`, in metres.
    ///
    /// If the activity's array of `Location`s is empty, returns `nil`.
    var altitudeDescended: CLLocationDistance? {
        var altitudeLost = 0.0
        for i in 0..<(self.locations.count - 1) {
            guard self.locations[i].altitude > self.locations[i + 1].altitude else { continue }
            altitudeLost += self.locations[i].altitude - self.locations[i + 1].altitude
        }
        return altitudeLost
    }
    
    /// Returns a `MapPolyline` from the list of `Location`s within the `Activity`.
    var polyline: MapPolyline {
        MapPolyline(coordinates: self.locations.map { $0.toCLLocationCoordinate2D })
    }
    
    static let sampleData: [Activity] = [
        Activity(name: "Example Activity", endDate: Date.now, locations: []),
        Activity(name: "Another Activity", endDate: Date.now, locations: []),
        Activity(name: "One More Activity", endDate: Date.now, locations: [])
    ]
}
