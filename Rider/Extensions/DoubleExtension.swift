//
//  DoubleExtension.swift
//  Rider
//
//  Created by Derek Chai on 24/04/2024.
//

import Foundation

extension Double {
    func roundedString(to dp: Int = 0) -> String {
        String(format: "%.\(dp)f", self)
    }
}
