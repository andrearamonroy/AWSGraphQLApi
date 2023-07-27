//
//  BackButton.swift
//  FrenchApp
//
//  Created by Andrea on 7/27/23.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrowshape.left.fill")
                .font(.headline)
                .foregroundColor(.cyan)
                .padding()
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
