//
//  Logo.swift
//  YGOSearch
//
//  Created by Efe Demir on 9/4/24.
//

import SwiftUI
import AVFoundation

struct Logo: View {
    @State private var flipped = false
    @State private var isAnimating = false
    @State private var isPlayingOST = false
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        GeometryReader { geometry in
            Image("ygo")
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width, alignment: .center)
                .shadow(color: .yellow.opacity(0.7), radius: isAnimating ? 30 : 10, x: 0, y: 0)
                .rotation3DEffect(
                    .degrees(flipped ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
                .onAppear {
                    setupAudioSession()
                }
                .onTapGesture {
                    withAnimation {
                        flipped.toggle()
                    }
                }
                .onLongPressGesture(minimumDuration: 0.5, perform: {
                    isPlayingOST.toggle()
                    if isPlayingOST {
                        playSound(soundName: "winning")
                    } else {
                        stopSound()
                    }
                })
                .onDisappear {
                    stopSound()
                    audioPlayer = nil
                }
        }
    }
    
    func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    func playSound(soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: "mp3") else {
            print("The sound file was not found.")
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("An error occurred while trying to play the audio: \(error)")
        }
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }
}
