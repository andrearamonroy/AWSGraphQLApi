////
////  PlayerView.swift
////  FrenchApp
////
////  Created by Andrea on 5/30/23.
////

import SwiftUI

struct PlayerView: View {
    var audio: String
    @StateObject private var audioPlayer = AudioPlayer()
    @StateObject private var audioVM = AudioVM(audioURLManager: AudioURLManager())
    @State private var value: Double = 0.0
    @State private var isEditing = false
    
    
//    let timer = Timer
//        .publish(every: 0.5, on: .main, in: .common)
       // .autoconnect()


    var body: some View {
        VStack {
            if let url = audioVM.audioURL {
                VStack {
                    HStack {
                        playbackSpeedMenu
                        
                        playbackControlButtons(url: url)
                        
                        PlayButton(systemName: "stop.fill") { audioPlayer.stopAudio() }
                    }
                    .padding(20)
                    
                    // Slider
    
                    
                    
                }
            } else {
                Text("Audio URL not available")
            }
        }
        .onAppear {
            audioVM.loadAudio(audioKey: audio)
        
        }
     
    }
    
    private var playbackSpeedMenu: some View {
        Menu {
            Button(action: { audioPlayer.playbackSpeed = 0.5 }) {
                Image(systemName: "tortoise")
                Text("0.5x")
            }
            Button(action: { audioPlayer.playbackSpeed = 1.0 }) {
                Image(systemName: "tortoise.fill")
                Text("1.0x")
            }
            Button(action: { audioPlayer.playbackSpeed = 1.5 }) {
                Image(systemName: "hare.fill")
                Text("1.5x")
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
        }
    }
    
    private func playbackControlButtons(url: URL) -> some View {
        HStack {
            PlayButton(systemName: "gobackward.10") { audioPlayer.seekBackward() }

            PlayButton(systemName: audioPlayer.isPlaying ? "pause" : "play") { audioPlayer.togglePlayback(withURL: url) }
            
            PlayButton(systemName: "goforward.10") { audioPlayer.seekForward() }
        }
    }
}
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(audio: "vousEtes.mp3")
    }
}
