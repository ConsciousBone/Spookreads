//
//  ExperimentsView.swift
//  AutoBooks
//
//  Created by Evan Plant on 06/04/2026.
//

import SwiftUI

struct ExperimentsView: View {
    @State private var textToSpeak = ""
    var body: some View {
        Form {
            Section("Speech synthesis") {
                TextField("Text to speak", text: $textToSpeak)
                
                Button {
                    speakText(textToSpeak)
                } label: {
                    Label("Speak text", systemImage: "mic")
                }
                
                Button {
                    continueSpeech()
                } label: {
                    Label("Continue speech", systemImage: "play")
                }
                
                Button {
                    pauseSpeech()
                } label: {
                    Label("Pause speech", systemImage: "pause")
                }
                
                Button {
                    stopSpeech()
                } label: {
                    Label("Stop speech", systemImage: "stop")
                }
            }
        }
    }
}

#Preview {
    ExperimentsView()
}
