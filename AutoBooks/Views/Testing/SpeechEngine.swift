//
//  SpeechEngine.swift
//  AutoBooks
//
//  Created by Evan Plant on 06/04/2026.
//

import Foundation
import AVFoundation

let synthesizer = AVSpeechSynthesizer()

func speakText(_ input: String) {
    let utterance = AVSpeechUtterance(string: input)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
    utterance.rate = 0.5
    synthesizer.speak(utterance)
}

func continueSpeech() {
    synthesizer.continueSpeaking()
}

func pauseSpeech() {
    synthesizer.pauseSpeaking(at: .immediate)
}

func stopSpeech() {
    synthesizer.stopSpeaking(at: .immediate)
}
