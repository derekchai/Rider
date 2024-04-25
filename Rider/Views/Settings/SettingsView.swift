//
//  SettingsView.swift
//  Rider
//
//  Created by Derek Chai on 25/04/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage(UserDefaultsKey.unitSystem) var unitSystem = UnitSystem.metric
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Picker("Units", selection: $unitSystem) {
                        Text("Metric").tag(UnitSystem.metric)
                        Text("Imperial").tag(UnitSystem.imperial)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
