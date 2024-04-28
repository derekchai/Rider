//
//  RiderApp.swift
//  Rider
//
//  Created by Derek Chai on 23/04/2024.
//

import SwiftUI
import SwiftData

@main @MainActor
struct RiderApp: App {
    static let subsystem = "youngboris.Rider"
    static let debugMode = false
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Activity.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: debugMode)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    static let previewContainer: ModelContainer = {
        do {
            let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
            let schema = Schema([Activity.self])
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
//            for _ in 1...3 {
//                container.mainContext.insert(Activity.random())
//            }
            
            container.mainContext.insert(Activity(name: "Empty Activity", locations: []))
            
            return container
        } catch {
            fatalError("Could not create ModelContainer for preview: \(error)")
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
