//
//  PodcastView.swift
//  FrenchApp
//
//  Created by Andrea on 6/24/23.
//

import SwiftUI

struct PodcastView: View {
    var audio : String
    @StateObject private var audioPlayer = AudioPlayer()
    @StateObject private var audioVM = AudioVM(audioURLManager: AudioURLManager())
    
    var body: some View {
        VStack {
            if let url = audioVM.audioURL {
               // Text("Audio URL: \(url.absoluteString)")
                   
                Button("Play Audio") {
                    audioPlayer.playAudio(withURL: url)
                }
                Button("Stop Audio") {
                    audioPlayer.stopAudio()
                }
            } else {
                Text("Audio URL not available")
            }
        }
        .onAppear {
            audioVM.loadAudio(audioKey: audio)
        }
    }
}
