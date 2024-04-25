//
//  TimePeriodPicker.swift
//  Rider
//
//  Created by Derek Chai on 25/04/2024.
//

import SwiftUI

struct TimePeriodPicker: View {
    @Binding var timePeriod: TimePeriod
    var body: some View {
        Picker("Time Period", selection: $timePeriod) {
            ForEach(TimePeriod.allCases) { timePeriod in
                Text(timePeriod.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    TimePeriodPicker(timePeriod: .constant(TimePeriod.allTime))
}
