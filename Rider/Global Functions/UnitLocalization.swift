//
//  GlobalFunctions.swift
//  Rider
//
//  Created by Derek Chai on 25/04/2024.
//

import Foundation
import SwiftUI

/// Returns a formatted string of a given SI base unit value in metres (distance),
/// metres per second (speed), or seconds (time), in various units depending on
/// the `unitSystem` string key for `UserDefaults`.
/// 
/// Returns MKS (metric) units if the `UserDefaults` string for key `unitSystem`
/// is `mks`, and returns FPS (imperial) units if the key is `fps`.
/// - Parameters:
///   - valueSI: The SI value, in metres, seconds, or metres per second.
///   - unit: The unit of the result.
///   - unitSystem: The unit system the result should be in.   
///   - toDp: The decimal places the result should be rounded to.
/// - Returns: The resulting formatted string.
func unitString(from valueSI: Double, in unit: Unit, with unitSystem: String, toDp: Int = 0) -> String {
    let value: Double
    if unitSystem == UnitSystem.metric {
        switch unit {
        case .m_ft:
            value = valueSI
        case .km_mi:
            value = valueSI / 1000
        case .s:
            value = valueSI
        case .kmh⁻¹_mih⁻¹:
            value = valueSI * 3.6
        }
    } else {
        let metres = Measurement(value: valueSI, unit: UnitLength.meters)
        let metresPerSecond = Measurement(value: valueSI, unit: UnitSpeed.metersPerSecond)
        
        switch unit {
        case .m_ft:
            value = metres.converted(to: UnitLength.feet).value
        case .km_mi:
            value = metres.converted(to: UnitLength.miles).value
        case .s:
            value = valueSI
        case .kmh⁻¹_mih⁻¹:
            value = metresPerSecond.converted(to: UnitSpeed.milesPerHour).value
        }
    }
    
    let unitAbbreviation: String
    
    if unitSystem == UnitSystem.metric {
        switch unit {
        case .m_ft:
            unitAbbreviation = "m"
        case .km_mi:
            unitAbbreviation = "km"
        case .s:
            unitAbbreviation = "s"
        case .kmh⁻¹_mih⁻¹:
            unitAbbreviation = "km/h"
        }
    } else {
        switch unit {
        case .m_ft:
            unitAbbreviation = "ft"
        case .km_mi:
            unitAbbreviation = "mi"
        case .s:
            unitAbbreviation = "s"
        case .kmh⁻¹_mih⁻¹:
            unitAbbreviation = "mph"
        }
    }
    
    return "\(value.roundedString(to: toDp)) \(unitAbbreviation)"
}
