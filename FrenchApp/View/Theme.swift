//
//  Theme.swift
//  FrenchApp
//
//  Created by Andrea on 6/30/23.
//

import SwiftUI
import Authenticator

struct Theme: View {
    private let theme = AuthenticatorTheme()
    
        init() {
            // Colors
            theme.colors.background.interactive = .pink
            theme.colors.foreground.interactive = .red
            theme.colors.border.interactive = .pink
            
            // Fonts
            theme.fonts.title = .custom("Impact", size: 40)

            // Authenticator
            theme.components.authenticator.spacing.vertical = 20
            theme.components.authenticator.cornerRadius = 25
            theme.components.authenticator.backgroundColor = Color(uiColor: .systemGray6)
            theme.components.authenticator.padding = .init(
                top: 20,
                bottom: 20,
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
       
            VStack {
                Text("Sign In")
                    .font(theme.fonts.title)
                    .padding(.bottom, 20)
                
                // Username field
                TextField("Username", text: $username)
                    .padding()
                    .background(theme.components.field.backgroundColor)
                    .cornerRadius(theme.components.authenticator.cornerRadius)
                    .padding(.bottom, theme.components.field.spacing.vertical)
                
                // Password field
                SecureField("Password", text: $password)
                    .padding()
                    .background(theme.components.field.backgroundColor)
                    .cornerRadius(theme.components.authenticator.cornerRadius)
                    .padding(.bottom, theme.components.field.spacing.vertical)
                
                // Sign-in button
                Button(action: {
                    // Perform sign-in action
                }) {
                    Text("Sign In")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(theme.components.button.primary.cornerRadius)
                        .padding(.bottom, theme.components.button.primary.padding)
                }
                
                // Forgot password link
                Button(action: {
                    // Handle forgot password action
                }) {
                    Text("Forgot Password?")
                        .font(theme.components.button.link.font)
                        .foregroundColor(theme.colors.foreground.interactive)
                }
                .padding(.top, theme.components.button.link.padding)
                
            }
            .padding(theme.components.authenticator.padding)
            .background(theme.components.authenticator.backgroundColor)
            .cornerRadius(theme.components.authenticator.cornerRadius)
            .padding(.vertical, theme.components.authenticator.spacing.vertical)
        }

    }


struct Theme_Previews: PreviewProvider {
    static var previews: some View {
        Theme()
    }
}
