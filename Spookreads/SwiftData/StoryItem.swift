//
//  StoryItem.swift
//  Spookreads
//
//  Created by Evan Plant on 30/10/2025.
//

import Foundation
import SwiftData

@Model class StoryItem {
    var storyName: String
    var storyDescription: String
    var characters: [Character]
    var storyContent: String
    var date: Date
    var id = UUID()
    
    init(
        storyName: String = "",
        storyDescription: String = "",
        characters: [Character] = [],
        storyContent: String,
        date: Date = .now,
        id: UUID = UUID()
    ){
        self.storyName = storyName
        self.storyDescription = storyDescription
        self.characters = characters
        self.storyContent = storyContent
        self.date = date
        self.id = id
    }
}

