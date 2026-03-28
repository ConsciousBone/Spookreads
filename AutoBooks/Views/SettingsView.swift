//
//  SettingsView.swift
//  Spookreads
//
//  Created by Evan Plant on 30/10/2025.
//

import SwiftUI

struct SettingsView: View {
    let displayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "AutoBooks"
    // version stuff, ty searchino!
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    
    // accent
    @AppStorage("selectedAccentIndex") private var selectedAccentIndex = 5 // blue
    let accentColours = [
        Color.red.gradient, Color.orange.gradient,
        Color.yellow.gradient, Color.green.gradient,
        Color.mint.gradient, Color.blue.gradient,
        Color.purple.gradient, Color.brown.gradient,
        Color.white.gradient, Color.black.gradient
    ]
    let accentColourNames = [
        "Red", "Orange",
        "Yellow", "Green",
        "Mint", "Blue",
        "Purple", "Brown",
        "White", "Black"
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedAccentIndex) {
                        ForEach(accentColours.indices, id: \.self) { index in
                            Text(accentColourNames[index])
                        }
                    } label: {
                        Label("Accent Colour", systemImage: "paintpalette")
                    }
                }
                
                Section {
                    NavigationLink {
                        LegacySettingsView()
                    } label: {
                        Label("Legacy", systemImage: "hourglass")
                    }
                } footer: {
                    Text("Settings that were introduced in Spookreads and may be removed at any time.")
                }
                
                Section {
                    NavigationLink {
                        AboutView()
                    } label: {
                        Label("About \(displayName)", systemImage: "info")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
