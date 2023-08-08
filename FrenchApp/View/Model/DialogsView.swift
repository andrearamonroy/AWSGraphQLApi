//
//  DialogsView.swift
//  FrenchApp
//
//  Created by Andrea on 8/6/23.
//

import SwiftUI

struct DialogsView: View {
    var title: String
    var dialog: [String]
    var audio: String
    //@StateObject private var audioVM: AudioVM = AudioVM(audioManager: AudioManager())
    @State private var tappedIndices: [Int] = []
    
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(title)
                    .font(.custom(
                            "AmericanTypewriter",
                            fixedSize: 36))
                    .padding()
                ScrollView {
                ForEach(dialog.indices.filter { $0 % 2 == 0 || $0 == 0 }, id: \.self) { index in
                    let dialogText = dialog[index]
                    Text(dialogText)
                        .foregroundColor(.black)
                        .padding()
                        .background(.white)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                    
                        .onTapGesture {
                            tappedIndices.append(index)
                        }
                    
                    if tappedIndices.contains(index) {
                        let oddIndex = index + 1
                        if oddIndex < dialog.count {
                            let oddText = dialog[oddIndex]
                            Text(oddText)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color(hue: 0.606, saturation: 0.362, brightness: 0.916))                                .cornerRadius(8)
                                .shadow(radius: 4)
                        }
                    }
                }
            }
                PlayerView(audio: audio)
                    .padding(20)
                
            }
            .padding()
        }
        
    }
    
}

struct DialogsView_Previews: PreviewProvider {
    static var previews: some View {
        let dialog = ["Hello", "How are you?", "Goodbye", "See you later"]
        let audio = "sample_audio_url" // Replace with your actual audio URL
        
        return DialogsView(title: "first episode", dialog: dialog, audio: audio)
    }
}
