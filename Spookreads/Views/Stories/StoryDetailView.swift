//
//  StoryDetailView.swift
//  Spookreads
//
//  Created by Evan Plant on 02/11/2025.
//

import SwiftUI

struct StoryDetailView: View {
    @Binding var storyName: String
    @Binding var storyDescription: String
    @Binding var storyContent: String
    
    var body: some View {
        Form {
            Section {
                Text(storyName)
            } header: {
                Text("Story name")
            }
            
            Section {
                Text(storyDescription)
            } header: {
                Text("Story description")
            }
            
            Section {
                Text(storyContent)
            } header: {
                Text("Story content")
            }
        }
    }
}

#Preview {
    StoryDetailView(
        storyName: .constant("A story"),
        storyDescription: .constant("A very good story, maybe the best story"),
        storyContent: .constant("One day a man walked into a bar. Ouch.")
    )
}
