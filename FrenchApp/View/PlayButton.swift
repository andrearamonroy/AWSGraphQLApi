//
//  PlayButton.swift
//  FrenchApp
//
//  Created by Andrea on 5/30/23.
//

import SwiftUI

struct PlayButton: View {
    var systemName: String = "play"
    var fontSize: CGFloat = 24
    var color: Color = .white
    var action: () -> Void
    //function type that returns void
    var body: some View {
        
        Button{ action() } label: {
            Image(systemName: systemName)
                .font(.system(size: fontSize))
                .foregroundColor(color)
        }
        
    }
}

//changing branches commit
//cognitoauth extra
