//
//  RiderApp.swift
//  Rider
//
//  Created by Derek Chai on 23/04/2024.
//

import SwiftUI
import SwiftData

@main
struct RiderApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Activity.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
