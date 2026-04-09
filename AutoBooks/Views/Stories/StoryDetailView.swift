//
//  StoryDetailView.swift
//  Spookreads
//
//  Created by Evan Plant on 02/11/2025.
//

import SwiftUI

struct StoryDetailView: View {
    @State private var showingEditAlert = false
    @State private var editStoryName = ""
    @State private var editStoryDescription = ""
    
    let story: StoryItem
    private var shareText: String {
        "\(story.storyName)\n\(story.storyDescription)\n\(story.date.formatted(date: .long, time: .shortened))\n\n\(story.storyContent)"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(story.storyName)
                } header: {
                    Text("Name")
                }
                
                Section {
                    Text(story.storyDescription)
                } header: {
                    Text("Description")
                }
                
                Section {
                    Text(story.date.formatted(date: .long, time: .shortened))
                } header: {
                    Text("Creation date")
                }
                
                Section {
                    NavigationLink {
                        StorySpeechView(story: story)
                    } label: {
                        Label("Read as audiobook", systemImage: "waveform")
                    }
                }
                
                Section {
                    Text(story.storyContent)
                }
            }
            .navigationTitle(story.storyName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ShareLink(item: shareText) {
                        Label("Share book", systemImage: "square.and.arrow.up")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        editStoryName = story.storyName
                        editStoryDescription = story.storyDescription
                        showingEditAlert.toggle()
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                }
            }
            .alert("Edit story details", isPresented: $showingEditAlert) {
                TextField("Story name", text: $editStoryName)
                TextField("Story description", text: $editStoryDescription)
                Button("Save") {
                    withAnimation {
                        story.storyName = editStoryName
                        story.storyDescription = editStoryDescription
                    }
                }
                Button("Cancel", role: .cancel) {}
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
