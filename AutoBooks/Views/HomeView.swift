//
//  HomeView.swift
//  Spookreads
//
//  Created by Evan Plant on 30/10/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    let displayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "AutoBooks"
    // version stuff, ty searchino!
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    
    @Query(sort: \StoryItem.date, order: .reverse) var storyItems: [StoryItem]
    
    @State private var showingNewStorySheet = false
    
    @AppStorage("jumpscaresEnabled") private var jumpscaresEnabled = false
    
    var newestStory: StoryItem? {
        storyItems.first
    }
    private var newestShareText: String {
        guard let story = newestStory else { return "" }
        return "\(story.storyName)\n\(story.storyDescription)\n\n\(story.storyContent)"
    }
    
    @State private var randomStory: StoryItem? = nil
    private var randomShareText: String {
        guard let story = randomStory else { return "" }
        return "\(story.storyName)\n\(story.storyDescription)\n\n\(story.storyContent)"
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
                    VStack(alignment: .leading, spacing: 10) {
                        Text(greeting)
                            .font(.title)
                        Text("You've generated ^[\(storyItems.count) book](inflect: true) so far.")
                            .font(.subheadline)
                    }
                } header: {
                    Text("\(displayName) - version \(appVersion) build \(buildNumber)")
                }
                .listRowSeparator(.hidden)
                
                if let story = newestStory {
                    Section {
                        Button {
                            showingNewStorySheet.toggle()
                        } label: {
                            Label("New book", systemImage: "pencil")
                        }
                    }
                    
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
                        ShareLink(item: newestShareText) {
                            Label("Share book", systemImage: "square.and.arrow.up")
                        }
                    } header: {
                        Text("Newest book")
                    }
                } else {
                    Section {
                        Button {
                            showingNewStorySheet.toggle()
                        } label: {
                            Label("Try generating a book!", systemImage: "pencil")
                        }
                    } header: {
                        Text("No books")
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
                        ShareLink(item: randomShareText) {
                            Label("Share book", systemImage: "square.and.arrow.up")
                        }
                        Button {
                            print("new random book")
                            randomStory = storyItems.randomElement()
                        } label: {
                            Label("Shuffle", systemImage: "shuffle")
                        }
                    } header: {
                        Text("Random book")
                    }
                }
            }
            .sheet(isPresented: $showingNewStorySheet) {
                StoryCreationView()
                    .presentationDetents([.medium, .large])
            }
            .onAppear {
                if randomStory == nil {
                    randomStory = storyItems.randomElement()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
