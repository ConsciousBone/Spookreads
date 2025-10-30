//
//  StoryCreationView.swift
//  Spookreads
//
//  Created by Evan Plant on 30/10/2025.
//

import SwiftUI

struct Character: Identifiable {
    var name: String
    var description: String
    var id = UUID()
}

struct StoryCreationView: View {
    @State private var characters: [Character] = []
    
    @State private var showingAddAlert = false
    @State private var alertName = ""
    @State private var alertDesc = ""
    
    func submit(name: String, desc: String) {
        characters.append(
            Character (
                name: name,
                description: desc
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if characters.isEmpty {
                        Text("No characters.")
                    } else {
                        ForEach(characters) { character in
                            NavigationLink {
                                Text(character.name)
                                Text(character.description)
                            } label: {
                                Text(character.name)
                            }
                        }
                    }
                    Button {
                        showingAddAlert.toggle()
                    } label: {
                        Label("Add Character", systemImage: "plus")
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
            }
        }
    }
}

#Preview {
    StoryCreationView()
}
