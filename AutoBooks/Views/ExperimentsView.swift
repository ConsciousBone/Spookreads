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
                
                if speechEngine.isSpeaking {
                    Button {
                        withAnimation {
                            speechEngine.stopSpeech()
                        }
                    } label: {
                        Label("Stop speech", systemImage: "stop")
                    }
                    Button {
                        withAnimation {
                            speechEngine.pauseSpeech()
                        }
                    } label: {
                        Label("Pause speech", systemImage: "pause")
                    }
                } else if speechEngine.isPaused {
                    Button {
                        withAnimation {
                            speechEngine.stopSpeech()
                        }
                    } label: {
                        Label("Stop speech", systemImage: "stop")
                    }
                    Button {
                        withAnimation {
                            speechEngine.continueSpeech()
                        }
                    } label: {
                        Label("Continue speech", systemImage: "play")
                    }
                } else {
                    Button {
                        withAnimation {
                            speechEngine.speakText(textToSpeak)
                        }
                    } label: {
                        Label("Speak text", systemImage: "mic")
                    }
                }
            }
        }
        .navigationTitle("Experiments")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ExperimentsView()
}
