//
//  LegacySettingsView.swift
//  AutoBooks
//
//  Created by Evan Plant on 28/03/2026.
//

import SwiftUI

struct LegacySettingsView: View {
    @AppStorage("jumpscaresEnabled") private var jumpscaresEnabled = false
    @AppStorage("showLegacyStoryThemes") private var showLegacyStoryThemes = false
    @AppStorage("showLegacyStoryEnvironments") private var showLegacyStoryEnvironments = false
    
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $jumpscaresEnabled) {
                    Label("Jumpscares", systemImage: "theatermasks")
                }
                .tint(.red)
            } footer: {
                Text("This causes a slightly spooky image to appear on the screen for 1 second every 15 to 45 seconds.")
            }
            
            Section {
                Toggle(isOn: $showLegacyStoryThemes) {
                    Label("Legacy story themes", systemImage: "paintpalette")
                }
            } footer: {
                Text("This enables halloween story themes from Spookreads to be selected.")
            }
            
            Section {
                Toggle(isOn: $showLegacyStoryEnvironments) {
                    Label("Legacy story environments", systemImage: "mountain.2")
                }
            } footer: {
                Text("This enables halloween story environments from Spookreads to be selected.")
            }
        }
        .navigationTitle("Legacy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LegacySettingsView()
}
