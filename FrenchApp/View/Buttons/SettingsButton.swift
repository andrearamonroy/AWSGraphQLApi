//
//  SettingsButton.swift
//  FrenchApp
//
//  Created by Andrea on 7/26/23.
//

import SwiftUI

struct SettingsButton: View {
    var body: some View {
    
        Image(systemName: "gear")
            .font(.headline)
            .foregroundColor(.cyan)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(.white)
            )
            .shadow(color: Color.blue,
                    radius: 10, x: 0, y: 0)
            .padding()
        
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton()
            .previewLayout(.sizeThatFits)
    }
}
