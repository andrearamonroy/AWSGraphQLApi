////
////  PlayerView.swift
////  FrenchApp
////
////  Created by Andrea on 5/30/23.
////

import SwiftUI
import AVFoundation

struct PlayerView: View {
    var audio: String
    @StateObject private var audioPlayer = AudioPlayer()
    @StateObject private var audioVM = AudioVM(audioURLManager: AudioURLManager())
    @State private var value: Double = 0.0
    @State private var isEditing = false
    
    @State private var showAnimationView : Bool = false
    
    
    var title : String
    
//    let timer = Timer
//        .publish(every: 0.5, on: .main, in: .common)
       // .autoconnect()


    var body: some View {
        VStack {
            if let url = audioVM.audioURL {
                VStack {
                    HStack (spacing: 20){
                      
                        playbackSpeedMenu
                        Spacer()
                       
                        PlayButton(systemName: "gobackward.10") { audioPlayer.seekBackward() }
                        Spacer()

                        PlayButton(systemName: audioPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill", fontSize: 60) { audioPlayer.togglePlayback(withURL: url) }
                          
                       Spacer()
                        
                        PlayButton(systemName: "goforward.10") { audioPlayer.seekForward() }
                       Spacer()
                        
                        PlayButton(systemName: "stop.fill") { audioPlayer.stopAudio() }
                        }
    
                    
                    Slider(value: $audioPlayer.playbackProgress, in: 0.0...1.0)
                        .onChange(of: audioPlayer.playbackProgress) { newValue in
                            if newValue >= 1.0 {
                                audioPlayer.seekToBeginningAndPause()
                                showAnimationView = true
                            } else if newValue <= 0.0 {
                                audioPlayer.seekToBeginningAndPause()
                            }
                        }
                        .padding()
                        .tint(.white)
                }
              
            } else {
                Text("Audio URL not available")
            }
                
        }
       
        .fullScreenCover(isPresented:  $showAnimationView, content: {
            AnimationView(title: title)
        })
        
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
        .background(.white)
    }
    
//    private func playbackControlButtons(url: URL) -> some View {
//        HStack(spacing: 30) {
//
//            PlayButton(systemName: "gobackward.10") { audioPlayer.seekBackward() }
//            Spacer()
//
//            PlayButton(systemName: audioPlayer.isPlaying ? "pause" : "play", fontSize: 44) { audioPlayer.togglePlayback(withURL: url) }
//            Spacer()
//
//            PlayButton(systemName: "goforward.10") { audioPlayer.seekForward() }
//            Spacer()
//
//            PlayButton(systemName: "stop.fill") { audioPlayer.stopAudio() }
//            Spacer()
//        }
//    }
}
struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(audio: "vousEtes.mp3", title: "Episode 1")
            .previewLayout(.sizeThatFits)
    }
}
