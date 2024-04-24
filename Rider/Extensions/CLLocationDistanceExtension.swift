//
//  CLLocationDistanceExtension.swift
//  Rider
//
//  Created by Derek Chai on 24/04/2024.
//

import Foundation
import CoreLocation

extension CLLocationDistance {
    func localizedString(with unitSystem: UnitSystem, in unit: Units = .m_ft, toDp dp: Int = 0) -> String {
        if unitSystem == .mks {
            switch unit {
            case .m_ft:
                return String("\(self.roundedString(to: dp)) m")
            case .km_mi:
                let km = self / 1_000
                return String("\(km.roundedString(to: dp)) km")
            default:
                return "Invalid Units"
            }
        }
        
        switch unit {
        case .m_ft:
            let ft = self * 3.28084
            return String("\(ft.roundedString(to: dp)) ft")
        case .km_mi:
            let mi = self / 1_609.344
            return String("\(mi.roundedString(to: dp)) mi")
        default:
            return "Invalid Units"
        }
    }
}
