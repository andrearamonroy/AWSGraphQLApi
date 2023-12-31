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


@main
struct FrenchAppApp: App {
    //private let dataService = ProductionDataService()
    //  private let audioPlayer = AudioPlayer()
    @State private var showLaunchView: Bool = true
    
    init(){
        configureAmplify()
    }
    
    var body: some Scene {
        
        WindowGroup {
            ZStack {
                NavigationView{
                    AuthenticatorView()
                        .navigationBarHidden(true)
                }
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}

func configureAmplify() {
    let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
    let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
    let s3 = AWSS3StoragePlugin()
    let cognitoAuth = AWSCognitoAuthPlugin()
    
    do {
        try Amplify.add(plugin: apiPlugin)
        try Amplify.add(plugin: dataStorePlugin)
        try Amplify.add(plugin: s3)
        try Amplify.add(plugin: cognitoAuth)
        try Amplify.configure()
        print("Initialized Amplify");
    } catch {
        // simplified error handling for the tutorial
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
