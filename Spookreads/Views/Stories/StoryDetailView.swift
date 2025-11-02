//
//  StoryDetailView.swift
//  Spookreads
//
//  Created by Evan Plant on 02/11/2025.
//

import SwiftUI

struct StoryDetailView: View {
    let story: StoryItem
    
    var body: some View {
        Form {
            Section {
                Text(story.storyName)
            } header: {
                Text("Story name")
            }
            
            Section {
                Text(story.storyDescription)
            } header: {
                Text("Story description")
            }
            
            Section {
                Text(story.storyContent)
            } header: {
                Text("Story content")
            }
        }
    }
}

#Preview {
    StoryDetailView(
        story: StoryItem(
            storyName: "A story",
            storyDescription: "Potentially the best story ever made, no one has a better story.",
            storyContent: "One day a man, he was the greatest man, walked into a bar, and let me tell you something, the bar went ouch, it was not a very good bar; they need to build a wall not a bar"
        )
    )
}
