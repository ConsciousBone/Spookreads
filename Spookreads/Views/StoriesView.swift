//
//  StoriesView.swift
//  Spookreads
//
//  Created by Evan Plant on 30/10/2025.
//

import SwiftUI
import SwiftData

struct StoriesView: View {
    // data of the swift variety
    @Environment(\.modelContext) var modelContext
    @State private var storyPath = [StoryItem]()
    @Query(sort: \StoryItem.date, order: .reverse) var storyItems: [StoryItem]
    
    var body: some View {
        NavigationStack {
            if storyItems.count == 0 {
                ContentUnavailableView {
                    Label("No stories", systemImage: "book")
                } description: {
                    Text("You haven't saved any stories yet.")
                } actions: {
                    Button {
                        print("showing story popup")
                    } label: {
                        Label("New story", systemImage: "plus")
                    }
                    .buttonStyle(.bordered)
                }
            } else {
                Form {
                    ForEach(storyItems) { story in
                        Section {
                            NavigationLink {
                                //StoryDetailView()
                                Text("todo")
                            } label: {
                                Text(story.storyName)
                                Text(story.storyDescription)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    StoriesView()
}
