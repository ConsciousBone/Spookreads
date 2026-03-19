//
//  AutoBooksApp.swift
//  AutoBooks
//
//  Created by Evan Plant on 30/10/2025.
//

import SwiftUI
import SwiftData

@main
struct AutoBooksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [StoryItem.self]) // gotta store stuff frfr
    }
}
