//
//  TimePeriod.swift
//  Rider
//
//  Created by Derek Chai on 25/04/2024.
//

import Foundation

enum TimePeriod: String, CaseIterable, Identifiable {
    case weekly = "1W"
    case monthly = "1M"
    case biannually = "6M"
    case yearly = "1Y"
    case allTime = "MAX"
    
    var id: Self { self }
}
