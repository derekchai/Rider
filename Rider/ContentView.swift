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
    var body: some View {
        TabView {
            RecentActivitiesView()
                .tabItem {
                    Label("Activities", systemImage: "figure.run.square.stack")
                }
            
            Text("Map Page")
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Activity.self, inMemory: true)
}
