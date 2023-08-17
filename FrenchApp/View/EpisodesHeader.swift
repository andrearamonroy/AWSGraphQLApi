//
//  EpisodesHeader.swift
//  FrenchApp
//
//  Created by Andrea on 8/15/23.
//

import SwiftUI

struct EpisodesHeader: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .padding()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .padding(.top, UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first?.windows.first?.safeAreaInsets.top)
    
    }
}

struct EpisodesHeader_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesHeader(title: "Episodes Title")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
