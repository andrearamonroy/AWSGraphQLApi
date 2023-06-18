//
//  CognitoAuthVM.swift
//  FrenchApp
//
//  Created by Andrea on 6/13/23.
//

import Foundation
import Amplify
import AWSCognitoAuthPlugin
import Combine

class CongnitoAuthManager {
    
    func getAuth() -> AnyPublisher <AuthSession, Error> {
        Amplify.Publisher.create {
            try await Amplify.Auth.fetchAuthSession()
            
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

class CognitoAuthVM {
    let cognitoAuth : CongnitoAuthManager
    var cancellables = Set<AnyCancellable>()
    
    init (cognitoAuth: CongnitoAuthManager){
        self.cognitoAuth = cognitoAuth
    }
    
    func loadAuth(){
        cognitoAuth.getAuth()
            .sink {
                if case let .failure(authError) = $0 {
                    print("Fetch session failed with error \(authError)")
                }
            }
    receiveValue: { session in
        print("Is user signed in - \(session.isSignedIn)")
    }
    .store(in: &cancellables)
    }
    
    
}
