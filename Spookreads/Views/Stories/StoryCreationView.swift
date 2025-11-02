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

struct Story: Decodable {
    var storyName: String
    var storyDescription: String
    var storyContent: String
}

struct StoryCreationView: View {
    @Environment(\.dismiss) var dismiss // dismiss sheet programatically, i would use
                                        // presentationmode but its gonna be deprecated soon
    
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
        "Nightmare", "Trick or treat"
    ]
    
    @State private var selectedStoryEnvironmentIndex = 0
    let storyEnvironments = [
        "Foggy night", "Graveyard",
        "Abandoned street", "City center",
        "Haunted house", "Party"
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
        "The person-about-town.", // also inspector calls aah
        "Hard-headed business person.", // we're running out of ideas here
        "All bark, no bite."
    ]
    
    func deleteCharacter(at offsets: IndexSet) {
        characters.remove(atOffsets: offsets)
    }
    
    var generateButtonDisabled: Bool {
        characters.isEmpty ||
        (
            selectedStoryModeIndex == 1 && preciseDescription
            .trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        )
    }
    
    private func buildAIPrompt(intro: String) -> String {
        let charactersBlock: String
        if characters.isEmpty {
            charactersBlock = "No characters provided."
        } else {
            charactersBlock = characters
                .map {
                    "- \($0.name): \($0.description)"
                }
                .joined(separator: "\n")
        }
        
        return """
        \(intro)
        
        Characters:
        \(charactersBlock)
        
        Respond ONLY with compact JSON in this EXACT format:
        {"storyName":"", "storyDescription":"", "storyContent":""}
        
        JSON field rules:
        - "storyName": a short title fitting for the story, 2 to 6 words.
        - "storyDescription": 1 to 2 sentences describing the premise of the story.
        - "storyContent": the full story text, around 2 to 4 paragraphs long.
        
        Rules for your response:
        - No markdown. No code fences. No extra text.
        - All fields should include just what is necessary. Nothing more.
        - If the theme could be considered unsafe, creatively adapt it while keeping tone and context consistent.
        - Be vivid and original.
        """
    }
    
    private var aiPromptNormal: String {
        buildAIPrompt(intro:
            """
            You are generating a story based on the provided theme, environment, and characters.
            
            Theme: \(storyThemes[selectedStoryThemeIndex]).
            Environment: \(storyEnvironments[selectedStoryEnvironmentIndex]).
            """
        )
    }
    
    private var aiPromptPrecise: String {
        buildAIPrompt(intro:
            """
            You are generating a story based on the provided description and characters.
            
            Description: \(preciseDescription)
            """
        )
    }
    
    private var aiPromptRandom: String {
        selectedStoryThemeIndex = Int.random(in: 0..<storyThemes.count)
        selectedStoryEnvironmentIndex = Int.random(in: 0..<storyEnvironments.count)
        
        return buildAIPrompt(intro:
            """
            You are generating a story based on the provided theme, environment, and characters.
            
            Theme: \(storyThemes[selectedStoryThemeIndex]).
            Environment: \(storyEnvironments[selectedStoryEnvironmentIndex]).
            """
        )
    }
    
    @State private var isLoading = false
    
    @State private var aiStoryName = ""
    @State private var aiStoryDescription = ""
    @State private var aiStoryContent = ""
    @State private var errorText = ""
    
    private func decodeStory(from text: String) -> Story? {
        let cleaned = cleanAIJSON(text)
        guard let data = cleaned.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(Story.self, from: data)
    }
    
    private func generateStory() {
        isLoading = true
        errorText = ""
        aiStoryName = ""
        aiStoryContent = ""
        aiStoryDescription = ""
        
        if selectedStoryModeIndex == 0 { // normal
            sendRequestToAI(prompt: aiPromptNormal) { result in
                isLoading = false
                switch result {
                case .success(let raw):
                    if let aiStory = decodeStory(from: raw) {
                        aiStoryName = aiStory.storyName
                        aiStoryDescription = aiStory.storyDescription
                        aiStoryContent = aiStory.storyContent
                    }
                case .failure(let err):
                    errorText = err.localizedDescription
                }
            }
        }
        
        if selectedStoryModeIndex == 1 { // precise
            sendRequestToAI(prompt: aiPromptPrecise) { result in
                isLoading = false
                switch result {
                case .success(let raw):
                    if let aiStory = decodeStory(from: raw) {
                        aiStoryName = aiStory.storyName
                        aiStoryDescription = aiStory.storyDescription
                        aiStoryContent = aiStory.storyContent
                    }
                case .failure(let err):
                    errorText = err.localizedDescription
                }
            }
        }
        
        if selectedStoryModeIndex == 2 { // random
            sendRequestToAI(prompt: aiPromptRandom) { result in
                isLoading = false
                switch result {
                case .success(let raw):
                    if let aiStory = decodeStory(from: raw) {
                        aiStoryName = aiStory.storyName
                        aiStoryDescription = aiStory.storyDescription
                        aiStoryContent = aiStory.storyContent
                    }
                case .failure(let err):
                    errorText = err.localizedDescription
                }
            }
        }
    }
    
    @State private var testing = false
    
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
                        Label("Description mode", systemImage: "pencil")
                    }
                } header: {
                    Text("Modes")
                }
                
                if selectedStoryModeIndex == 0 {
                    Section { // normal, picker based
                        Picker(selection: $selectedStoryThemeIndex) {
                            ForEach(storyThemes.indices, id: \.self) { index in
                                Text(storyThemes[index])
                            }
                        } label: {
                            Label("Theme", systemImage: "paintpalette")
                        }
                        
                        Picker(selection: $selectedStoryEnvironmentIndex) {
                            ForEach(storyEnvironments.indices, id: \.self) { index in
                                Text(storyEnvironments[index])
                            }
                        } label: {
                            Label("Environment", systemImage: "mountain.2")
                        }
                        
                        Button {
                            withAnimation {
                                selectedStoryThemeIndex = Int.random(in: 0..<storyThemes.count)
                                selectedStoryEnvironmentIndex = Int.random(in: 0..<storyEnvironments.count)
                            }
                        } label: {
                            Label("Randomise", systemImage: "shuffle")
                        }
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
                
                Section {
                    Button {
                        print("generating story")
                        generateStory()
                    } label: {
                        if isLoading {
                            ProgressView()
                        } else {
                            Label("Generate story", systemImage: "wand.and.sparkles")
                        }
                    }
                    .disabled(generateButtonDisabled)
                    
                    if !errorText.isEmpty { // error has done an error
                        Text("An error has occured, please try again.")
                        Text(errorText)
                    }
                }
                
                if !aiStoryName.isEmpty {
                    Section {
                        Text(aiStoryName)
                    } header: {
                        Text("Story name")
                    }
                }
                
                if !aiStoryDescription.isEmpty {
                    Section {
                        Text(aiStoryDescription)
                    } header: {
                        Text("Story description")
                    }
                }
                
                if !aiStoryContent.isEmpty {
                    Section {
                        Text(aiStoryContent)
                    } header: {
                        Text("Story content")
                    }
                }
                
                if !aiStoryContent.isEmpty {
                    Section {
                        Button {
                            print("saving story")
                            let storyItem = StoryItem(
                                storyName: aiStoryName,
                                storyDescription: aiStoryDescription,
                                storyContent: aiStoryContent,
                                date: .now
                            )
                            modelContext.insert(storyItem)
                            storyPath = [storyItem]
                            print("story saved")
                        } label: {
                            Label("Save story", systemImage: "checkmark")
                        }
                    }
                }
                
                Section {
                    Toggle(isOn: $testing) {
                        Label("Show debug info", systemImage: "ant")
                    }
                    .tint(.red)
                }
                
                if testing {
                    Section {
                        Text("\(selectedStoryModeIndex)")
                    } header: {
                        Text("selectedStoryModeIndex")
                    }
                    
                    Section {
                        Text(verbatim: "\(characters)")
                    } header: {
                        Text("characters")
                    }
                    
                    Section {
                        Text(aiPromptNormal)
                    } header: {
                        Text("aiPromptNormal")
                    }
                    
                    Section {
                        Text(aiPromptPrecise)
                    } header: {
                        Text("aiPromptPrecise")
                    }
                    
                    Section {
                        Text(aiPromptRandom)
                    } header: {
                        Text("aiPromptRandom")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Close", systemImage: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    StoryCreationView()
}
