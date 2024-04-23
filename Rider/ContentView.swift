//
//  ContentView.swift
//  Rider
//
//  Created by Derek Chai on 23/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Activity]
    
    @State private var locationDataManager = LocationDataManager()

    var body: some View {
        Button("Start updating location") {
            locationDataManager.startUpdatingLocation()
        }
        Button("Stop updating location") {
            locationDataManager.stopUpdatingLocation()
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Activity(name: "", endDate: Date(), points: [])
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Activity.self, inMemory: true)
}
