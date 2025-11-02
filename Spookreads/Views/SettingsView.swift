//
//  SettingsView.swift
//  Spookreads
//
//  Created by Evan Plant on 30/10/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("jumpscaresEnabled") private var jumpscaresEnabled = false
    
    // accent
    @AppStorage("selectedAccentIndex") private var selectedAccentIndex = 1 // orange
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
    }
}

#Preview {
    SettingsView()
}
