////
////  PlayerView.swift
////  FrenchApp
////
////  Created by Andrea on 5/30/23.
////
//
//import SwiftUI
//
//
//
//
//struct PlayerView: View {
//    var audio : String
//    //@StateObject var audioVM : AudioViewModel
//    @State private var value: Double = 0.0
//    var isPreview: Bool = false //music doesn't play automatically on the preview
//    //@StateObject var audioManager: AudioManager
//    @State private var isEditing: Bool = false
//
//    //timer publisher (is a method) for slider comes with Combine framework
//    let timer = Timer
//        .publish(every: 0.5, on: .main, in: .common)
//        .autoconnect()
//
//
//    var body: some View {
//        VStack {
//            ScrollView {
//                //DialogView(dialog: audioVM.audio.dialog)
//            }
//            if let players = audio.player{
//                VStack {
//
//                }
//                HStack{
//                    //repeat
//                    //change icon color when isLooping is true
//                    let color : Color = audio.isLooping ? .teal : .white
//                    PlayButton(systemName: "repeat", color: color){audioManager.toggleLoop()} //action closure
//                    Spacer()
//
//                    //backward
//                    PlayButton(systemName: "gobackward.10"){ players.currentTime -= 10 }
//                    //substract 10 from current time
//                    Spacer()
//
//                    //playPause
//                    PlayButton(systemName: audio.isPlaying ? "pause.circle.fill" : "play.circle.fill" , fontSize: 44){
//                        audio.playPause()
//                    }
//                    Spacer()
//
//                    //foward
//                    PlayButton(systemName: "goforward.10"){ players.currentTime += 10 }
//                    Spacer()
//
//                    //stop
//                    PlayButton(systemName: "stop.fill"){ audioManager.stop()}
//                }
//            }
//        }
//        .onAppear{
//            audio.startPlayer(audio: audioVM.audio.audio)
//        }
//    }
//}
//
