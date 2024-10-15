//
//  TextToSpeechHelper.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 12/10/24.
//

import AVFoundation

class TextToSpeechHelper {
    private let synthesizer: AVSpeechSynthesizer

    init() {
        self.synthesizer = AVSpeechSynthesizer()
    }

    /// Function to speak a given text in Indonesian language
    func speakIndonesian(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        
        // Set language to Indonesian (Indonesia)
        utterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        
        // Optionally, you can control the speed and pitch of the voice
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate // You can adjust this to change speed
        utterance.pitchMultiplier = 1.0 // You can change this to adjust the pitch
        
        synthesizer.speak(utterance)
    }
    
    /// Stop speaking
    func stopSpeaking() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
    }
}
