//
//  ActivityDetailedView.swift
//  Rider
//
//  Created by Derek Chai on 24/04/2024.
//

import SwiftUI
import MapKit

struct ActivityDetailedView: View {
    let activity: Activity
    
    var body: some View {
        Section(activity.dateStopped?.formatted(date: .abbreviated, time: .shortened) ?? "No date") {
            VStack(alignment: .leading) {
                Map {
                    activity.polyline
                        .strokeStyle(style: .mainLine)
                        .stroke(.blue)
                }
                .frame(height: 200)
                .allowsHitTesting(false)
                
                VStack(alignment: .leading) {
                    Text(activity.name)
                        .font(.headline)
                    
                    Text("^[\(activity.locations.count) point](inflect: true)")
                    
                    Text(activity.distance.localizedString(with: .fps, in: .km_mi, toDp: 5))
                }
                .padding()
            }
        }
        .listRowInsets(EdgeInsets())
    }
}

#Preview {
    ActivityDetailedView(activity: Activity.sampleData.first!)
}
