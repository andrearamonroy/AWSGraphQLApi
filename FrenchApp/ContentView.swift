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
    @State private var showSettings: Bool = false
    
    
    init(dataService: ProductionDataService) {
        _vm = StateObject(wrappedValue: PodcastViewModel(dataService: dataService))
    }
    
    var body: some View {
        
        
        
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
            VStack{
                
                ForEach(vm.podcasts, id: \.id) { podcast in
                    NavigationLink(destination: DialogView(dialog: podcast.dialog, audio: podcast.audio)) {
                        Text(podcast.title)
                        
                    }
                }
            }
            Spacer()
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

struct DialogView: View {
    var dialog: [String]
    var audio: String
    //@StateObject private var audioVM: AudioVM = AudioVM(audioManager: AudioManager())
    @State private var tappedIndices: [Int] = []
    
    
    var body: some View {
        VStack {
            List(dialog.indices.filter { $0 % 2 == 0 || $0 == 0 }, id: \.self) { index in
                let dialogText = dialog[index]
                Text(dialogText)
                    .foregroundColor(.primary)
                    .onTapGesture {
                        tappedIndices.append(index)
                    }
                
                if tappedIndices.contains(index) {
                    let oddIndex = index + 1
                    if oddIndex < dialog.count {
                        let oddText = dialog[oddIndex]
                        Text(oddText)
                            .foregroundColor(.white)
                            .listRowBackground(Color.gray)
                    }
                }
            }
            //PodcastView3()
        }
        VStack{
            PlayerView(audio: audio)
        }
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




//struct DialogView: View {
//    var dialog: [String]
//    //var audio: String
//    //var music : String
//    @StateObject private var audioVM: AudioVM = AudioVM(audioManager: AudioManager())
//
//    @State private var tappedIndices: [Int] = []
//
//    var body: some View {
//        VStack {
//            List(dialog.indices.filter { $0 % 2 == 0 || $0 == 0 }, id: \.self) { index in
//                let dialogText = dialog[index]
//                Text(dialogText)
//                    .foregroundColor(.primary)
//                    .onTapGesture {
//                        tappedIndices.append(index)
//                    }
//
//                if tappedIndices.contains(index) {
//                    let oddIndex = index + 1
//                    if oddIndex < dialog.count {
//                        let oddText = dialog[oddIndex]
//                        Text(oddText)
//                            .foregroundColor(.white)
//                            .listRowBackground(Color.gray)
//                    }
//                }
//            }
//
//            Button("Play") {
//                audioVM.loadAudio(audioKey: audio)
//            }
//        }
//        .onDisappear {
//            audioVM.audioPlayer?.stop()
//        }
//
//    }
//
//    func getAudio(){
//        Amplify.Storage.downloadData(key: "verbeAvoir.mp3") {result in
//            if case .sucess(let storageResult) = result {
//                self.music = storageResult.items
//            }
//        }
//    }
//}





    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    
    

