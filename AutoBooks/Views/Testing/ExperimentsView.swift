//
//  ExperimentsView.swift
//  AutoBooks
//
//  Created by Evan Plant on 06/04/2026.
//

import SwiftUI

struct ExperimentsView: View {
    @State private var speechEngine = SpeechEngine()
    @State private var textToSpeak = ""
    
    var body: some View {
        Form {
            Section("Speech synthesis") {
                TextField("Text to speak", text: $textToSpeak)
                
                Button {
                    speechEngine.speakText(textToSpeak)
                } label: {
                    Label("Speak text", systemImage: "mic")
                }
                
                Button {
                    speechEngine.continueSpeech()
                } label: {
                    Label("Continue speech", systemImage: "play")
                }
                
                Button {
                    speechEngine.pauseSpeech()
                } label: {
                    Label("Pause speech", systemImage: "pause")
                }
                
                Button {
                    speechEngine.stopSpeech()
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
