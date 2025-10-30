//
//  CharacterAboutView.swift
//  Spookreads
//
//  Created by Evan Plant on 30/10/2025.
//

import SwiftUI

struct CharacterAboutView: View {
    @Binding var name: String
    @Binding var description: String
    
    @State private var showingEditAlert = false
    @State private var alertName = ""
    @State private var alertDesc = ""
    
    func submit(editName: String, editDescription: String) {
        name = editName
        description = editDescription
    }
    
    var body: some View {
        Form {
            Section {
                Text(name)
            } header: {
                Text("Character name")
            }
            
            Section {
                Text(description)
            } header: {
                Text("Character description")
            }
            
            Section {
                Button {
                    print("edit")
                } label: {
                    Label("Edit character", systemImage: "pencil")
                }
            }
        }
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Edit character", isPresented: $showingEditAlert) {
            TextField("Character name", text: $alertName)
            TextField("Character description", text: $alertDesc)
            Button("Save") {
                submit(editName: alertName, editDescription: alertDesc)
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

#Preview {
    CharacterAboutView(
        name: .constant("A name"),
        description: .constant("Maybe a human idk")
    )
}
