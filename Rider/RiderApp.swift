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
//    @State private var userPreferences = UserPreferences(unitSystem: .fps)
    
    static let subsystem = "youngboris.Rider"
    static let debugMode = true
    static let unitSystem: UnitSystem = .mks
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Activity.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: debugMode)
        
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
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
