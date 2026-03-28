//
//  LegacySettingsView.swift
//  AutoBooks
//
//  Created by Evan Plant on 28/03/2026.
//

import SwiftUI

struct LegacySettingsView: View {
    @AppStorage("jumpscaresEnabled") private var jumpscaresEnabled = false
    
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $jumpscaresEnabled) {
                    Label("Jumpscares", systemImage: "theatermasks")
                }
                .tint(.red)
            } header: {
                Text("Spooky season")
            } footer: {
                Text("This causes a slightly spooky image to appear on the screen for 1 second every 15 to 45 seconds.")
            }
        }
        .navigationTitle("Legacy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LegacySettingsView()
}
