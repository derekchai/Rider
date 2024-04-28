//
//  ActivityChart.swift
//  Rider
//
//  Created by Derek Chai on 25/04/2024.
//

import SwiftUI
import SwiftData
import Charts

struct ActivityChart: View {
    @Query private var activities: [Activity]
    
    @Binding var rawSelectedDate: Date?
    @Binding var timePeriod: TimePeriod
    
    private var unitTime: Calendar.Component {
        switch timePeriod {
        case .weekly:
            return .day
        case .monthly:
            return .day
        case .biannually:
            return .month
        case .yearly:
            return .month
        case .allTime:
            return .month
        }
    }
    
    private var xAxisVisibleDomain: Int {
        switch timePeriod {
        case .weekly:
            return 3600 * 24 * 7
        case .monthly:
            return 3600 * 24 * 30
        case .biannually:
            return 3600 * 24 * 183 // TBC
        case .yearly:
            return 3600 * 24 * 183 // TBC
        case .allTime:
            return 3600 * 24 * 183 // TBC
        }
    }
    
    var body: some View {
        VStack {
            Text(rawSelectedDate?.formatted() ?? "No date selected")
            Chart {
                ForEach(activities) { activity in
                    if let dateStopped = activity.dateStopped {
                        BarMark(
                            x: .value("X", dateStopped, unit: unitTime),
                            y: .value("Y", activity.distance)
                        )
                    }
                }
                
                if let rawSelectedDate {
                    RuleMark(
                        x: .value("Selected", rawSelectedDate, unit: .day)
                    )
                    .foregroundStyle(.gray.opacity(0.3))
                    .offset(yStart: -10)
                    .zIndex(-1)
                    .annotation(
                        position: .top,
                        spacing: 0,
                        overflowResolution: .init(
                            x: .fit(to: .chart),
                            y: .fit(to: .chart)
                        )
                    ) {
                        Text(rawSelectedDate.formatted())
                    }
                }
            }
            .chartScrollableAxes(.horizontal)
            .chartXSelection(value: $rawSelectedDate)
            .chartXVisibleDomain(length: xAxisVisibleDomain)
            .chartYAxisLabel("m")
            .padding(.top, 120)
        }
    }
}

#Preview {
    ActivityChart(rawSelectedDate: .constant(Date.now), timePeriod: .constant(.weekly))
        .modelContainer(RiderApp.previewContainer)
}
