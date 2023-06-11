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

@main
struct FrenchAppApp: App {
    //private let dataService = ProductionDataService()
  //  private let audioPlayer = AudioPlayer()
    
    init(){
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(dataService: ProductionDataService())
        }
    }
}
func configureAmplify() {
    let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
    let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
    do {
        try Amplify.add(plugin: apiPlugin)
        try Amplify.add(plugin: dataStorePlugin)
        try Amplify.configure()
        print("Initialized Amplify");
    } catch {
        // simplified error handling for the tutorial
        print("Could not initialize Amplify: \(error)")
    }
}
