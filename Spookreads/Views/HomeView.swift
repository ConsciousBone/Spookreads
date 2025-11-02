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
                            Text(story.storyDescription)
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
            
            Section {
                Toggle(isOn: $jumpscaresEnabled) {
                    Label("Jumpscares", systemImage: "theatermasks")
                }
                .tint(.red)
            } header: {
                Text("It's spooky season!")
            }
        }
        .sheet(isPresented: $showingNewStorySheet) {
            StoryCreationView()
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    HomeView()
}
