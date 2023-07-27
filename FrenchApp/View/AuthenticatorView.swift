//
//  AuthenticatorView.swift
//  FrenchApp
//
//  Created by Andrea on 7/25/23.
//

import SwiftUI
import Authenticator

struct AuthenticatorView: View {
    private let theme = AuthenticatorTheme()

        init() {
            // Colors
            theme.colors.background.interactive = .cyan
            theme.colors.foreground.interactive = .white
            theme.colors.border.interactive = .pink
            
            
            // Fonts
            theme.fonts.title = .custom("Noteworthy-Bold", size: 40)

            // Authenticator
            theme.components.authenticator.spacing.vertical = 20
            theme.components.authenticator.cornerRadius = 25
            //theme.components.authenticator.backgroundColor = Color(uiColor: .systemGray6)
        
            theme.components.authenticator.padding = .init(
                top: 60,
                bottom: 10,
                trailing: 50,
                leading: 50
            )
            
            // Buttons
            theme.components.button.primary.cornerRadius = 100
            theme.components.button.primary.padding = 20
            theme.components.button.link.font = .custom("Noteworthy-Bold", size: 15)
                    
            // Fields
            theme.components.field.spacing.vertical = 20
            theme.components.field.backgroundColor = .init(uiColor: .init(dynamicProvider: {
                return $0.userInterfaceStyle == .dark ? .black : .white
            })) // A dynamic color according to the color mode
            
            // Alerts
            theme.components.alert.cornerRadius = 30
            theme.components.alert.padding = 50
        }
    var body: some View {
        Authenticator { _ in
            //put content view here
            //and this view in the main app
            ContentView(dataService: ProductionDataService())
        }
        .authenticatorTheme(theme)
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .top, endPoint: .bottom))
      
    }
}

struct AuthenticatorView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatorView()
    }
}

