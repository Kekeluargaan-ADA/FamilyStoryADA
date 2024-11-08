//
//  SoundEffectHelper.swift
//  FamilyStoryADA
//
//  Created by Vincent Junior Halim on 07/11/24.
//

import Foundation
import AVFoundation


class SoundEffectHelper: NSObject , ObservableObject , AVAudioPlayerDelegate  {
    private var audioRecorder : AVAudioRecorder!
    private var audioPlayer : AVAudioPlayer!
    private var session : AVAudioSession! = AVAudioSession.sharedInstance()
    
    func startRecording(){
        let options = [
            AVAudioSession.CategoryOptions.defaultToSpeaker,
            AVAudioSession.CategoryOptions.duckOthers,
            AVAudioSession.CategoryOptions.interruptSpokenAudioAndMixWithOthers
        ]
        
        do {
            try session.setCategory(.playAndRecord, mode: .spokenAudio, options: AVAudioSession.CategoryOptions(options))
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch let error {
            fatalError("Can not setup the Recording: \(error.localizedDescription)")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("recording.wav")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVLinearPCMBitDepthKey: 16,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            print(audioRecorder.url)
        } catch let error {
            fatalError("Failed to Setup the Recording: \(error.localizedDescription)")
        }
    }
    
    
    func stopRecording(){
        audioRecorder.stop()
        do {
            try session.setActive(false)
        } catch _ {
        }
    }
    
    
    func playSoundDelay(fileName: String) async {
        do {
            // Stop current playback if audioPlayer is already playing
            if audioPlayer?.isPlaying == true {
                audioPlayer?.stop()
            }
            
            // Load the audio file
            guard let folderURL = Bundle.main.url(forResource: fileName, withExtension: "m4a") else {
                print("Error: Sound file not found.")
                return
            }
            
            // Initialize and play the sound
            audioPlayer = try AVAudioPlayer(contentsOf: folderURL)
            audioPlayer?.prepareToPlay()
            await MainActor.run {
                audioPlayer?.play()
                print("Playing sound: \(fileName)")
            }
        } catch {
            print("Error initializing audio player: \(error.localizedDescription)")
        }
    }
    
    func playSound(fileName: String) {
        // Check if the audio player is already set up with the correct sound
        if let player = audioPlayer, player.url?.lastPathComponent == "\(fileName).mp3" {
            if player.isPlaying {
                // Reset to the beginning if already playing
                player.currentTime = 0
            } else {
                // Play immediately if not already playing
                player.play()
            }
            print("Playing sound immediately: \(fileName)")
            return
        }
        
        // Load the audio file and initialize player only if needed
        do {
            guard let folderURL = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
                print("Error: Sound file not found.")
                return
            }
            
            audioPlayer = try AVAudioPlayer(contentsOf: folderURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            print("Playing sound: \(fileName)")
        } catch {
            print("Error initializing audio player: \(error.localizedDescription)")
        }
    }
    
    // New method to stop sound playback
    func stopSound() {
        if audioPlayer?.isPlaying == true {
            audioPlayer.stop()
            print("Sound playback stopped.")
        } else {
            print("No sound is currently playing.")
        }
    }
}
