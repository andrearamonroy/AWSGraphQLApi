//
//  DialogBubble.swift
//  FrenchApp
//
//  Created by Andrea on 6/24/23.
//

import SwiftUI

struct DialogBubble: View {
    let text: String
 
    
    var body: some View {
        VStack() {
            HStack {
                Text(text)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                    .listRowSeparator(.hidden)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct DialogBubble_Previews: PreviewProvider {
    static var previews: some View {
        DialogBubble(text: "hello")
    }
}
