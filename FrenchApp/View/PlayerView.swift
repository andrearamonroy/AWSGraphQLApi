////
////  PlayerView.swift
////  FrenchApp
////
////  Created by Andrea on 5/30/23.
////
////
//import SwiftUI
//import Authenticator
//import Amplify
//import SwiftUI
//
//struct SignUpView: View {
//    @State private var username = ""
//    @State private var password = ""
//    @State private var email = ""
//    @State private var signUpMessage = ""
//    @State private var showConfirmationView = false
//    
//    private let authManager = AuthManager()
//    
//    var body: some View {
//        VStack {
//            TextField("Username", text: $username)
//                .padding()
//            SecureField("Password", text: $password)
//                .padding()
//            TextField("Email", text: $email)
//                .padding()
//            
//            Button(action: {
//                Task {
//                    do {
//                        try await signUp()
//                    } catch let error as AuthError {
//                        signUpMessage = "Error: \(error)"
//                    } catch {
//                        signUpMessage = "Unexpected error: \(error)"
//                    }
//                }
//            }) {
//                Text("Sign Up")
//                    .font(.title)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            
//            Text(signUpMessage)
//                .foregroundColor(.green)
//                .padding()
//            
//            NavigationLink(destination: ConfirmationView(username: username), isActive: $showConfirmationView) {
//                EmptyView()
//            }
//            .hidden()
//        }
//        .padding()
//    }
//    
//    private func signUp() async throws {
//        try await authManager.signUp(username: username, password: password, email: email)
//        
//        // User signed up successfully, navigate to confirmation view
//        showConfirmationView = true
//    }
//}
//
//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
//
//struct ConfirmationView: View {
//    @State private var confirmationCode = ""
//    @State private var confirmationMessage = ""
//
//    private let authManager = AuthManager()
//
//    let username: String
//
//    var body: some View {
//        VStack {
//            Text("Enter Confirmation Code:")
//                .font(.headline)
//
//            TextField("Confirmation Code", text: $confirmationCode)
//                .padding()
//
//            Button(action: {
//                Task {
//                    do {
//                        try await confirmSignUp()
//                    } catch let error as AuthError {
//                        confirmationMessage = "An error occurred while confirming sign up: \(error)"
//                    } catch {
//                        confirmationMessage = "Unexpected error: \(error)"
//                    }
//                }
//            }) {
//                Text("Confirm")
//            }
//
//            Text(confirmationMessage)
//                .foregroundColor(.red)
//                .padding()
//        }
//    }
//
//    private func confirmSignUp() async throws {
//        try await authManager.confirmSignUp(for: username, with: confirmationCode)
//
//        // Confirmation successful, update confirmation message
//        confirmationMessage = "Confirmation successful!"
//    }
//}
