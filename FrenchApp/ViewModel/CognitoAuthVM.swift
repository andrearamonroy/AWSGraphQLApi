//
//  CognitoAuthVM.swift
//  FrenchApp
//
//  Created by Andrea on 6/13/23.
//
//
//import Foundation
//import Amplify
//import AWSCognitoAuthPlugin
//import Combine
//
//class AuthManager {
//    
//    func signUp(username: String, password: String, email: String) async {
//        let userAttributes = [AuthUserAttribute(.email, value: email)]
//        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
//        do {
//            let signUpResult = try await Amplify.Auth.signUp(
//                username: username,
//                password: password,
//                options: options
//            )
//            if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
//                print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
//            } else {
//                print("SignUp Complete")
//            }
//        } catch let error as AuthError {
//            print("An error occurred while registering a user \(error)")
//        } catch {
//            print("Unexpected error: \(error)")
//        }
//    }
//    
//    func confirmSignUp(for username: String, with confirmationCode: String) async {
//        do {
//            let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(
//                for: username,
//                confirmationCode: confirmationCode
//            )
//            print("Confirm sign up result completed: \(confirmSignUpResult.isSignUpComplete)")
//        } catch let error as AuthError {
//            print("An error occurred while confirming sign up \(error)")
//        } catch {
//            print("Unexpected error: \(error)")
//        }
//    }
//}


//
//class CongnitoAuthManager {
//
//    func getAuth() -> AnyPublisher <AuthSession, Error> {
//        Amplify.Publisher.create {
//            try await Amplify.Auth.fetchAuthSession()
//
//        }
//        .receive(on: DispatchQueue.main)
//        .eraseToAnyPublisher()
//    }
//}
//
//class CognitoAuthVM {
//    let cognitoAuth : CongnitoAuthManager
//    var cancellables = Set<AnyCancellable>()
//
//    init (cognitoAuth: CongnitoAuthManager){
//        self.cognitoAuth = cognitoAuth
//    }
//
//    func loadAuth(){
//        cognitoAuth.getAuth()
//            .sink {
//                if case let .failure(authError) = $0 {
//                    print("Fetch session failed with error \(authError)")
//                }
//            }
//    receiveValue: { session in
//        print("Is user signed in - \(session.isSignedIn)")
//    }
//    .store(in: &cancellables)
//    }
//
//
//}
