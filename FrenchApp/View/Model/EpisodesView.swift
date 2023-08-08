//
//  EpisodesView.swift
//  FrenchApp
//
//  Created by Andrea on 8/6/23.
//

import SwiftUI

struct EpisodesView: View {
    var episodes : [Episode]
    var body: some View {
        ZStack{
        LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
        
        VStack{
            ForEach(episodes, id: \.id) { episode in
                NavigationLink {
                    DialogsView(title: episode.title, dialog: episode.dialog, audio: episode.audio)
                } label: {
                    Text(episode.title)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 4)
                    
                }
            }
            
        }
    }
    
        
    }
    
    
    
}


struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView(episodes: [Episode(podcastID: "1", title: "episode 1", audio: "audio 1")])
    }
}
