//
//  StoryCreationView.swift
//  Spookreads
//
//  Created by Evan Plant on 30/10/2025.
//

import SwiftUI
import SwiftData

struct Character: Identifiable {
    var name: String
    var description: String
    var id = UUID()
}

struct StoryCreationView: View {
    @Environment(\.modelContext) var modelContext
    @State private var storyPath = [StoryItem]()
    @Query(sort: \StoryItem.date, order: .reverse) var storyItems: [StoryItem]
    
    @State private var characters: [Character] = []
    
    @State private var showingAddAlert = false
    @State private var alertName = ""
    @State private var alertDesc = ""
    
    @State private var selectedStoryModeIndex = 0
    let storyModes = [
        "Normal", "Precise",
        "Random"
    ]
    
    @State private var selectedStoryThemeIndex = 0
    let storyThemes = [
        "Halloween", "Scary",
        "Ghosts", "Candy",
        "Pumpkin", "Zombies",
        "Vampires", "Werewolves",
        "Witches", "Mystery",
        "Nightmare", "Graveyard",
        "Foggy night", "Trick or treat"
    ]
    
    @State private var preciseDescription = ""
    
     func submit(name: String, desc: String) {
        characters.append(
            Character(
                name: name,
                description: desc
            )
        )
    }
    func submitRandom() {
        characters.append(
            Character(
                name: charRandomNames.randomElement() ?? "",
                description: charRandomDescriptions.randomElement() ?? ""
            )
        )
    }
    
    let charRandomNames = [
        "Amelia", "Andy",
        "Dave", "Ben",
        "Charlie", "Nick",
        "Valerie", "James",
        "Emma", "Simon",
        "William", "Tim",
        "Tia", "Ella",
        "Freya", "Ava",
        "Freddy", "Nathan",
        "Joe", "Arthur",
        "Lucas", "Abigale",
        "Maya", "Adriana",
        "Courtney", "Oliver",
        "Beau", "Logan",
        "Morgan", "Natalie", // yes the gang
        "Anya", "Mitchell",
        "Michael", "Tom",
        "Ethan", "George",
        "Kate", "Catherine",
        "Leo", "Paula"
    ]
    let charRandomDescriptions = [
        "Cheerful, light-hearted.",
        "Scary but nice.",
        "Evil prankster.",
        "Menacing bully.",
        "Strong leader.",
        "Easily spooked.",
        "Half shy, half assertive.", // inspector calls aah
        "The man-about-town.", // also inspector calls aah
        "Hard-headed business man.", // we're running out of ideas here
        "All bark, no bite."
    ]
    
    func deleteCharacter(at offsets: IndexSet) {
        characters.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if characters.isEmpty {
                        Text("No characters.")
                    } else {
                        ForEach($characters) { $char in
                            NavigationLink {
                                CharacterAboutView(
                                    name: $char.name,
                                    description: $char.description
                                )
                            } label: {
                                Text(char.name)
                            }
                        }
                        .onDelete(perform: deleteCharacter)
                    }
                    
                    Button {
                        showingAddAlert.toggle()
                    } label: {
                        Label("Add Character", systemImage: "plus")
                    }
                    
                    Button {
                        submitRandom()
                    } label: {
                        Label("Add Character (random)", systemImage: "dice")
                    }
                } header: {
                    Text("Characters")
                }
                .alert("New character", isPresented: $showingAddAlert) {
                    TextField("Character name", text: $alertName)
                    TextField("Character description", text: $alertDesc)
                    Button("Add") {
                        submit(name: alertName, desc: alertDesc)
                    }
                    Button("Cancel", role: .cancel) {}
                }
                
                Section { // mode selector
                    Picker(selection: $selectedStoryModeIndex) {
                        ForEach(storyModes.indices, id: \.self) { index in
                            Text(storyModes[index])
                        }
                    } label: {
                        Label("Description modes", systemImage: "pencil")
                    }
                } header: {
                    Text("Modes")
                }
                
                if selectedStoryModeIndex == 0 {
                    Section { // normal, picker based
                        Text("normal editing")
                    } header: {
                        Text("Story description")
                    }
                }
                
                if selectedStoryModeIndex == 1 {
                    Section { // precise, text based
                        TextField("Story description", text: $preciseDescription)
                    } header: {
                        Text("Story description")
                    }
                }
            }
        }
    }
}

#Preview {
    StoryCreationView()
}
