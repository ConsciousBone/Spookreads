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
    @Binding var pronouns: String
    
    @State private var showingEditAlert = false
    @State private var alertName = ""
    @State private var alertDesc = ""
    @State private var alertPronouns = ""
    
    func submit(editName: String, editDescription: String, editPronouns: String) {
        name = editName
        description = editDescription
        pronouns = editPronouns
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
                Text(pronouns)
            } header: {
                Text("Character pronouns")
            }
            
            Section {
                Button {
                    alertName = name
                    alertDesc = description
                    alertPronouns = pronouns
                    showingEditAlert.toggle()
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
            TextField("Character pronouns", text: $alertPronouns)
            Button("Save") {
                submit(editName: alertName, editDescription: alertDesc, editPronouns: alertPronouns)
            }
            .disabled(alertName.isEmpty || alertDesc.isEmpty || alertPronouns.isEmpty)
            Button("Cancel", role: .cancel) {}
        }
    }
}

#Preview {
    CharacterAboutView(
        name: .constant("A name"),
        description: .constant("Maybe a human idk"),
        pronouns: .constant("he/they")
    )
}
