//
//  FrenchAppApp.swift
//  FrenchApp
//
//  Created by Andrea on 5/19/23.
//

import SwiftUI
import Amplify
import AWSDataStorePlugin
import UIKit
import AWSAPIPlugin
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
import Authenticator
import AWSPredictionsPlugin


@main
struct FrenchAppApp: App {
<<<<<<< HEAD
   
=======
    //private let dataService = ProductionDataService()
    //  private let audioPlayer = AudioPlayer()
>>>>>>> cognitoAuth
    
   init(){
        configureAmplify()
    }
    
    var body: some Scene {
        
        WindowGroup {
<<<<<<< HEAD
          
            Authenticator { state in
                VStack {
                    Text("Hello, \(state.user.username)")
                    ContentView(dataService: ProductionDataService())
                    Button("Sign out") {
                        Task {
                            await state.signOut()
                        }
                    }
                }

=======
            NavigationView{
                AuthenticatorView()
                    .navigationBarHidden(true)
>>>>>>> cognitoAuth
            }
        }
    }
}

func configureAmplify() {
    let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
    let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
    let s3 = AWSS3StoragePlugin()
    let cognitoAuth = AWSCognitoAuthPlugin()
    let predictions = AWSPredictionsPlugin()
    
    do {
        try Amplify.add(plugin: apiPlugin)
        try Amplify.add(plugin: dataStorePlugin)
        try Amplify.add(plugin: s3)
        try Amplify.add(plugin: cognitoAuth)
        try Amplify.add(plugin: predictions)
        try Amplify.configure()
        print("Initialized Amplify");
    } catch {
        // simplified error handling
        print("Could not initialize Amplify: \(error)")
    }
}

//Authenticator { state in
//                VStack {
//                    Text("Hello, \(state.user.username)")
//                    ContentView(dataService: ProductionDataService())
//                    Button("Sign out") {
//                        Task {
//                            await state.signOut()
//                        }
//                    }
//                }
//
//            }
//            //ContentView(dataService: ProductionDataService())
