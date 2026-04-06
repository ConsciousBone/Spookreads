//
//  StorySpeechView.swift
//  AutoBooks
//
//  Created by Evan Plant on 06/04/2026.
//

import SwiftUI

struct StorySpeechView: View {
    @State private var speechEngine = SpeechEngine()
    let story: StoryItem
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(Color(.systemGroupedBackground))
            VStack {
                Label(story.storyName, systemImage: "waveform")
                    .font(.title.bold())
                    .padding(.bottom)
                
                HStack(spacing: 20) {
                    if speechEngine.isSpeaking {
                        Button {
                            speechEngine.pauseSpeech()
                        } label: {
                            Circle()
                                .frame(width: 70, height: 70)
                                .overlay {
                                    Image(systemName: "pause")
                                        .foregroundStyle(.background)
                                        .font(.title.bold())
                                }
                        }
                        
                        Button {
                            speechEngine.stopSpeech()
                        } label: {
                            Circle()
                                .frame(width: 70, height: 70)
                                .overlay {
                                    Image(systemName: "stop")
                                        .foregroundStyle(.background)
                                        .font(.title.bold())
                                }
                        }
                    } else if speechEngine.isPaused {
                        Button {
                            speechEngine.continueSpeech()
                        } label: {
                            Circle()
                                .frame(width: 70, height: 70)
                                .overlay {
                                    Image(systemName: "play")
                                        .foregroundStyle(.background)
                                        .font(.title.bold())
                                }
                        }
                        
                        Button {
                            speechEngine.stopSpeech()
                        } label: {
                            Circle()
                                .frame(width: 70, height: 70)
                                .overlay {
                                    Image(systemName: "stop")
                                        .foregroundStyle(.background)
                                        .font(.title.bold())
                                }
                        }
                    } else {
                        Button {
                            speechEngine.speakText(story.storyContent)
                        } label: {
                            Circle()
                                .frame(width: 70, height: 70)
                                .overlay {
                                    Image(systemName: "play")
                                        .foregroundStyle(.background)
                                        .font(.title.bold())
                                }
                        }
                    }
                }
            }
            .padding(50)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .navigationTitle("Audiobook")
        }
    }
}
