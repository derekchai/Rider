//
//  ContentView.swift
//  Rider
//
//  Created by Derek Chai on 23/04/2024.
//

import SwiftUI
import SwiftData
import OSLog

struct ContentView: View {
    private let log = Logger(subsystem: RiderApp.subsystem, category: "ContentView")
    
    @Environment(\.modelContext) private var modelContext
    @Query private var activities: [Activity]
    
    @State private var locationDataManager = LocationDataManager()
    @State private var inActivity = false
    @State private var activitySaved = false
    @State private var activityName = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities) { activity in
                    ActivityDetailedView(activity: activity)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(activities[index])
                    }
                }
            }
            .navigationTitle("Recent Activities")
            .overlay {
                if activities.isEmpty {
                    ContentUnavailableView {
                        Label("No Activities", systemImage: "point.bottomleft.filled.forward.to.point.topright.scurvepath")
                    } description: {
                        Text("Activities you record will appear here.")
                    }
                }
            }
            .toolbar {
                if !inActivity && locationDataManager.currentActivity != nil && !activitySaved {
                    ToolbarItem(placement: .topBarLeading) {
                        TextField("Activity name", text: $activityName)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save activity") {
                            guard let currentActivity = locationDataManager.currentActivity else { return }
                            currentActivity.name = activityName
                            activitySaved = true
                            activityName = ""
                            modelContext.insert(currentActivity)
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if inActivity {
                            stopActivity()
                        } else {
                            startActivity()
                        }
                    } label: {
                        Image(systemName: inActivity ? "pause.fill" : "play.fill")
                            .contentTransition(.symbolEffect)
                    }
                }
            }
        }
    }
    
    // MARK: - Actions
    
    private func startActivity() {
        locationDataManager.startNewActivity(name: "New activity")
        inActivity = true
    }
    
    private func stopActivity() {
        locationDataManager.stopActivity()
        inActivity = false
        activitySaved = false
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Activity.self, inMemory: true)
}
