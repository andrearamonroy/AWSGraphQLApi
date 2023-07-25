//
//  DialogView.swift
//  FrenchApp
//
//  Created by Andrea on 6/24/23.
//

import SwiftUI

struct DialogView: View {
    var dialog: [String]
    var audio: String
   // @State private var tappedIndices: [Int] = []

    
    var body: some View {
        
        VStack {
            ScrollView{
                ForEach(dialog, id: \.self) { dialogs in
                    Text(dialogs)
                }
            }
        }
        .padding()
        VStack {
            PodcastView(audio: audio)
        }
    }
}
struct DialogView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleDialog = [
            "Jeanne: Vous avez des carottes?",
            "translation",
            "Le marchard: Oui, j'ai des carrottes. Un kilo?",
            "translation",
            "Jeanne: Oui, un kilo, s'il vous plait",
            "translation",
            "Le marchard: Autre chose?"
        ]
        
        let sampleAudio = "sample_audio_file.mp3"
        
        return DialogView(dialog: sampleDialog, audio: sampleAudio)
    }
}

/**
 ForEach(dialog.indices, id: \.self) { index in
     let dialogText = dialog[index]
     let isEven = index % 2 == 0
     
     if index == 0 || isEven {
         //let direction: DialogRowDirection = (index / 2) % 2 == 0 ? .left : .right
         
         DialogBubble(
             text: dialogText
         )
         
         .onTapGesture {
             
             tappedIndices.append(index)
         }
     }
     
     if tappedIndices.contains(index) {
         let oddIndex = index + 1
         if oddIndex < dialog.count {
             let oddText = dialog[oddIndex]
             Text(oddText)
         }
     }
 }
}
 */
