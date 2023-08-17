//
//  AnimationView.swift
//  FrenchApp
//
//  Created by Andrea on 8/16/23.
//

import SwiftUI
struct AnimationView: View {
    var title: String
   
    @State private var showAnimationView : Bool = false
    @State private var loops : Int = 0
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.584, green: 0.704, blue: 1.000).edgesIgnoringSafeArea(.all)
// Set background color to cover the entire screen
                
                ConfettiView().opacity(0.8) // Adjust opacity to control the blend with the background
                VStack {
                    Text("Congrats!")
                        .font(.largeTitle)
                        .padding()
                    Text("You listened to")
                        .font(.title3)
                    Text(title)
                        .font(.title3)
                    
                
                }
            } //end of ZStack
            
           
            .navigationBarHidden(true) // Hide the navigation bar if needed
        }
    }
}


struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView(title: "Episode 1")
    }
}
