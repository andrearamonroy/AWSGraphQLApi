//
//  DialogBubble.swift
//  FrenchApp
//
//  Created by Andrea on 6/24/23.
//

import SwiftUI

struct DialogBubble: View {
    let text: String
    var backgroundColor: Color {
        return direction == .left ? .gray : .blue
    }
    
    var foregroundColor: Color {
        return direction == .left ? .black : .white
    }
 
    let direction: DialogRowDirection
    
    var body: some View{
        //let frameAlignment: Alignment = direction == .left ? .leading : .trailing
        VStack(alignment: direction == .left ? .leading : .trailing){
            HStack{
                Text(text)
                    .padding()
                    .background(backgroundColor)
                    .foregroundColor(foregroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                    .listRowSeparator(.hidden)
            }
            .frame(maxWidth: 300, alignment: direction == .left ? .leading : .trailing)
        }
    }
}

struct DialogBubble_Previews: PreviewProvider {
    static var previews: some View {
        DialogBubble(text: "hello", direction: DialogRowDirection.left)
    }
}
