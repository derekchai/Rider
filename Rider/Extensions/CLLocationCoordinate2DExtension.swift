//
//  CLLocationCoordinate2DExtension.swift
//  Rider
//
//  Created by Derek Chai on 23/04/2024.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Codable {
    public enum CodingKeys: String, CodingKey {
        case _latitude
        case _longitude
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: ._latitude)
        try container.encode(longitude, forKey: ._longitude)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        latitude = try values.decode(Double.self, forKey: ._latitude)
        longitude = try values.decode(Double.self, forKey: ._longitude)
    }
}
