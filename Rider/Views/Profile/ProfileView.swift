//
//  ProfileView.swift
//  Rider
//
//  Created by Derek Chai on 25/04/2024.
//

import SwiftUI

struct ProfileView: View {
    @State private var timePeriod: TimePeriod = .weekly
    @State private var presentingSettings = false
    @State private var rawSelectedDate: Date?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TimePeriodPicker(timePeriod: $timePeriod)
                    .listRowInsets(EdgeInsets())
                
                ActivityChart(rawSelectedDate: $rawSelectedDate, timePeriod: $timePeriod)
                    .frame(height: 300)
            }
            .padding()
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem {
                    settingsButton
                }
            }
        }
        .sheet(isPresented: $presentingSettings) {
            SettingsView()
        }
    }
    
    // MARK: - View Parameters
    
    private var settingsButton: some View {
        Button {
            presentingSettings.toggle()
        } label: {
            Image(systemName: "gearshape")
        }
    }
}

#Preview {
    ProfileView()
}
