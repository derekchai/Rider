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
    
    static func random() -> Activity {
        let adjectives = ["Sunny", "Cloudy", "Rainy", "Windy", "Snowy"]
        let modes = ["Walk", "Run", "Ride", "Hike"]
        
        let name = "A \(adjectives[Int.random(in: 0..<adjectives.count)]) \(modes[Int.random(in: 0..<modes.count)])"
        
        let startLocation = Location(latitude: Double.random(in: -90...90), longitude: Double.random(in: -180...180), altitude: Double.random(in: -10...200), horizontalAccuracy: 3, verticalAccuracy: 3, speed: Double.random(in: 0...50), speedAccuracy: 3, course: 0, courseAccuracy: 0, timestamp: Date.now - Double.random(in: 86_400...31_536_000))
        
        var activity = Activity(name: name, locations: [startLocation])
        
        for i in 1...Int.random(in: 50...100) {
            var speed = activity.locations[i - 1].speed + Double.random(in: -5...5)
            if speed < 0 { speed = 0 }
            
            activity.locations.append(Location(latitude: activity.locations[i - 1].latitude + Double.random(in: -0.0001...0.0001), longitude: activity.locations[i - 1].longitude + Double.random(in: -0.0001...0.0001), altitude: activity.locations[i - 1].altitude + Double.random(in: -1...1), horizontalAccuracy: 3, verticalAccuracy: 3, speed: speed, speedAccuracy: 3, course: 0, courseAccuracy: 0, timestamp: startLocation.timestamp + (Double(i) * 1.2)))
        }
        
        return activity
    }
    
    static let sampleData: [Activity] = [
        Activity(name: "Example Activity", locations: []),
        Activity(name: "Another Activity", locations: []),
        Activity(name: "One More Activity", locations: [])
    ]
}
