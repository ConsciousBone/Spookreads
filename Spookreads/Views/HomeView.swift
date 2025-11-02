//
//  HomeView.swift
//  Spookreads
//
//  Created by Evan Plant on 30/10/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(sort: \StoryItem.date, order: .reverse) var storyItems: [StoryItem]
    
    @State private var showingNewStorySheet = false
    
    @AppStorage("jumpscaresEnabled") private var jumpscaresEnabled = false
    
    var newestStory: StoryItem? {
        storyItems.first
    }
    
    var randomStory: StoryItem? {
        storyItems.randomElement()
    }
    
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 5..<12:
            return "Good morning!"
        case 12..<17:
            return "Good afternoon!"
        default:
            return "Good evening!"
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(greeting)
                        .font(.title)
                }
                
                if let story = newestStory {
                    Section {
                        NavigationLink {
                            StoryDetailView(story: story)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(story.storyName)
                                    .multilineTextAlignment(.leading)
                                Text(story.storyDescription)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    } header: {
                        Text("Newest story")
                    }
                } else {
                    Section {
                        Button {
                            showingNewStorySheet.toggle()
                        } label: {
                            Label("Try generating a story!", systemImage: "pencil")
                        }
                    } header: {
                        Text("No stories")
                    }
                }
                
                if let story = randomStory {
                    Section {
                        NavigationLink {
                            StoryDetailView(story: story)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(story.storyName)
                                    .multilineTextAlignment(.leading)
                                Text(story.storyDescription)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    } header: {
                        Text("Random story")
                    }
                }
                
                Section {
                    Toggle(isOn: $jumpscaresEnabled) {
                        Label("Jumpscares", systemImage: "theatermasks")
                    }
                    .tint(.red)
                } header: {
                    Text("It's spooky season!")
                } footer: {
                    Text("This causes a slightly spooky image to appear on the screen for 1 second every 15 to 45 seconds.")
                }
            }
            .sheet(isPresented: $showingNewStorySheet) {
                StoryCreationView()
                    .presentationDetents([.medium, .large])
            }
        }
    }
}

#Preview {
    HomeView()
}
