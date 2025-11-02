//
//  ContentView.swift
//  Spookreads
//
//  Created by Evan Plant on 30/10/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("jumpscaresEnabled") private var jumpscaresEnabled = false
    @State private var showingJumpscare = false
    @State private var jumpscareTaskUUID = UUID()
    
    private func runJumpscareLoop() async {
        guard jumpscaresEnabled else { return }
        
        while jumpscaresEnabled {
            let delay = Double(Int.random(in: 15...45))
            try? await Task.sleep(for: .seconds(delay))
            // check if user turned it off for safety
            guard jumpscaresEnabled else { break }
            
            await MainActor.run {
                showingJumpscare = true // show jumpscare ofc
            }
            
            try? await Task.sleep(for: .seconds(1)) // show for 1 second
            
            await MainActor.run {
                showingJumpscare = false // and then hide it
            }
        }
    }
    
    var body: some View {
        ZStack {
            TabView {
                Tab("Home", systemImage: "house") {
                    HomeView()
                }
                Tab("Stories", systemImage: "book") {
                    StoriesView()
                }
                Tab("Settings", systemImage: "gear") {
                    SettingsView()
                }
            }
            
            if showingJumpscare {
                Image("Jumpscare")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
        .task(id: jumpscareTaskUUID) {
            await runJumpscareLoop()
        }
        .onChange(of: jumpscaresEnabled) {
            jumpscareTaskUUID = UUID()
            if !jumpscaresEnabled {
                showingJumpscare = false
            }
        }
    }
}

#Preview {
    ContentView()
}
