//
//  RiderTests.swift
//  RiderTests
//
//  Created by Derek Chai on 23/04/2024.
//

import XCTest
@testable import Rider

final class RiderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testActivityDistance() throws {
        // Arrange
        let meridionalCircumnavigationOfEarth = Activity(name: "Meridional Circumnavigation of the Earth", locations: [
            Location(latitude: 0, longitude: 0, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, speed: 0, speedAccuracy: 0, course: 0, courseAccuracy: 0, timestamp: Date.now),
            Location(latitude: 90, longitude: 0, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, speed: 0, speedAccuracy: 0, course: 0, courseAccuracy: 0, timestamp: Date.now),
            Location(latitude: 0, longitude: 0, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, speed: 0, speedAccuracy: 0, course: 0, courseAccuracy: 0, timestamp: Date.now),
            Location(latitude: -90, longitude: 0, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, speed: 0, speedAccuracy: 0, course: 0, courseAccuracy: 0, timestamp: Date.now),
            Location(latitude: 0, longitude: 0, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, speed: 0, speedAccuracy: 0, course: 0, courseAccuracy: 0, timestamp: Date.now)
        ])
        let earthMeridionalCircumference: Double = 40_007_860
        
        // Act
        let activityDistance = meridionalCircumnavigationOfEarth.distance
        let error = abs((activityDistance / earthMeridionalCircumference) - 1)
        
        // Assert
        XCTAssert(error < 0.0000001)
    }
    
    func testActivityAltitudeAscendedAndDescended() throws {
        // Arrange
        let someActivity = Activity(name: "Ascending and Descending", locations: [
            Location(latitude: 0, longitude: 0, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, speed: 0, speedAccuracy: 0, course: 0, courseAccuracy: 0, timestamp: Date.now),
            Location(latitude: 10, longitude: 0, altitude: 20, horizontalAccuracy: 0, verticalAccuracy: 0, speed: 0, speedAccuracy: 0, course: 0, courseAccuracy: 0, timestamp: Date.now),
            Location(latitude: 20, longitude: 0, altitude: 10, horizontalAccuracy: 0, verticalAccuracy: 0, speed: 0, speedAccuracy: 0, course: 0, courseAccuracy: 0, timestamp: Date.now),
            Location(latitude: 30, longitude: 0, altitude: 40, horizontalAccuracy: 0, verticalAccuracy: 0, speed: 0, speedAccuracy: 0, course: 0, courseAccuracy: 0, timestamp: Date.now),
            Location(latitude: 40, longitude: 0, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, speed: 0, speedAccuracy: 0, course: 0, courseAccuracy: 0, timestamp: Date.now),
        ])
        
        // Act
        let altitudeAscended = someActivity.altitudeAscended
        let altitudeDescended = someActivity.altitudeDescended
        
        // Assert
        XCTAssert(altitudeAscended == 50)
        XCTAssert(altitudeDescended == 50)
    }
    
    func testA() throws {
        let someDouble = 3.14159
        print(someDouble.roundedString(to: 3))
    }
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
