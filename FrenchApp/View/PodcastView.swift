//
//  PodcastView.swift
//  FrenchApp
//
//  Created by Andrea on 6/24/23.
//

import SwiftUI

struct PodcastView: View {
    var audio: String
    @StateObject private var audioPlayer = AudioPlayer()
    @StateObject private var audioVM = AudioVM(audioURLManager: AudioURLManager())
    @State private var isDropdownExpanded = false


    var body: some View {
        VStack {
            if let url = audioVM.audioURL {
                VStack {
                    HStack {
                        Menu {
                            
                            Button(action: {
                                audioPlayer.playbackSpeed = 0.5
                            }) {
                                Image(systemName: "tortoise")
                                Text("0.5x")
                            }
                            Button(action: {
                                audioPlayer.playbackSpeed = 1.0
                            }) {
                                Image(systemName: "tortoise.fill")
                                Text("1.0x")
                            }
                            Button(action: {
                                audioPlayer.playbackSpeed = 1.5
                            }) {
                                Image(systemName: "hare.fill")
                                Text("1.5x")
                            }
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                        }
                        Spacer()
                        
                        PlayButton(systemName: "gobackward.10") {audioPlayer.seekBackward()}
                        Spacer()
                        PlayButton(systemName: audioPlayer.isPlaying ? "pause" : "play") { audioPlayer.togglePlayback(withURL: url)}
                        Spacer()
                        PlayButton(systemName: "goforward.10") { audioPlayer.seekForward()}
                        Spacer()
                        PlayButton(systemName:  "stop.fill") {audioPlayer.stopAudio()}
                        
                        
                    }.padding(20)
                    
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
}


