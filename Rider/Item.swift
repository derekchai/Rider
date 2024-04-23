//
//  Item.swift
//  Rider
//
//  Created by Derek Chai on 23/04/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
