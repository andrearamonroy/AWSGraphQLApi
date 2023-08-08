//
//  ContentView.swift
//  FrenchApp
//
//  Created by Andrea on 5/19/23.
//

import SwiftUI
import Amplify
import AVFoundation
import AWSS3StoragePlugin
import AWSCognitoAuthPlugin
import UIKit
import Authenticator


struct ContentView: View {
    @StateObject private var vm : PodcastViewModel
    
    
    init(dataService: ProductionDataService)  {
        _vm = StateObject(wrappedValue:  PodcastViewModel(dataService: dataService))
    }
    
    var body: some View {
    
        
        ScrollView {
            VStack{
                NavigationLink {
                    SettingsView()
                } label: {
                    HStack {
                        Spacer()
                        SettingsButton()
                    }
                    .padding()
                    
                    
                }
                
                Spacer()
                
                VStack {
                    ForEach(vm.podcasts.sorted(by: { $0.id < $1.id }), id: \.id){podcast in
                        NavigationLink {
                            if let episodes = podcast.episodes?.elements {
                                EpisodesView(episodes: episodes)
                                
                            }
                        } label: {
                            LevelButton(level: podcast.level)
                        }
                        .padding(10)

                    
                    }
                    
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            let dataService = ProductionDataService() // You should provide your actual data service here.
            ContentView(dataService: dataService)
                .toolbar(.hidden)
        }
    }
}



struct LevelButton: View {
    var level :  String
    var body: some View {
        
        Text(level) //using var to access a property in a struct
            .fontWeight(.bold)
            .font(.title)
            .padding()
            .background(Color.blue)
            .cornerRadius(40)
            .foregroundColor(Color.white)
            .padding(7)
            .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.blue, lineWidth: 5))
        
        
    }
    
}



struct PodcastView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Button("Upload Data") {
                Task {
                    do {
                        try await uploadData()
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
    
    func uploadData() async throws {
        let dataString = "Example file contents"
        let data = Data(dataString.utf8)
        let uploadTask = Amplify.Storage.uploadData(
            key: "ExampleKey2",
            data: data
        )
        for await progress in await uploadTask.progress {
            print("Progress: \(progress)")
        }
        let value = try await uploadTask.value
        print("Completed: \(value)")
    }
}

struct PodcastView2: View {
    var body: some View {
        VStack {
            Text("Hello")
            Button("Download Data") {
                Task {
                    await downloadData()
                }
            }
        }
    }
    
    func downloadData() async {
        do {
            let downloadTask = Amplify.Storage.downloadData(key: "ExampleKey2")
            
            for await progress in await downloadTask.progress {
                print("Progress: \(progress)")
            }
            
            let data = try await downloadTask.value
            print("Completed: \(data)")
            
            // Add your logic to handle the downloaded data here
        } catch {
            print("Error: \(error)")
        }
    }
}




//
//struct PodcastView3: View {
//    @StateObject private var audioPlayer = AudioPlayer()
//    @State private var audioURL: URL?
//
//    var body: some View {
//        VStack {
//            if let url = audioURL {
//                Text("Audio URL: \(url.absoluteString)")
//                    .padding()
//                Button("Play Audio") {
//                    audioPlayer.playAudio(withURL: url)
//                }
//                Button("Stop Audio") {
//                    audioPlayer.stopAudio()
//                }
//            } else {
//                Text("Audio URL not available")
//            }
//        }
//        .onAppear {
//            getAudioURL()
//        }
//    }
//
//    func getAudioURL() {
//        Task {
//            do {
//                let url = try await Amplify.Storage.getURL(
//                    key: "verbeAvoir.mp3", //here is where i change it to audio variable from dynamoDB.
//                    options: .init(
//                        pluginOptions: AWSStorageGetURLOptions(
//                            validateObjectExistence: true
//                        )
//                    )
//                )
//                audioURL = url
//            } catch {
//                print("Failed to get the URL: \(error)")
//            }
//        }
//    }
//}









        //            Button("Download and Play") {
        //                Task {
        //                    do {
        //                        let downloadTask = Amplify.Storage.downloadData(key: "public/verbeAvoir.mp3")
        //                        for await progress in await downloadTask.progress {
        //                            print("Progress: \(progress)")
        //                        }
        //                        let data = try await downloadTask.value
        //                        audioVM.playAudio(data: data)
        //                    } catch {
        //                        print("Failed to download audio: \(error)")
        //                    }
        //                }
        //            }






    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    
    

