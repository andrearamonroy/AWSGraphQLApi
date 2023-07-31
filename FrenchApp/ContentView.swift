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
        
        
        //        VStack{
        //            NavigationLink {
        //                SettingsView()
        //            } label: {
        //                HStack {
        //                    Spacer()
        //                    SettingsButton()
        //                }
        //
        //
        //            }
        //
        //            Spacer()
        
        
        
        VStack{
            
            ForEach(vm.podcasts, id: \.id) { podcast in
                NavigationLink(destination: DialogView(dialog: podcast.dialog, audio: podcast.audio)) {
                    Text(podcast.title)
                    Text(podcast.audio)
                
                    

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

















struct PodcastView5: View {
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
    //
    //func queryItems() async {
    //
    //    do{
    //        let podcasts = try await Amplify.DataStore.query(Podcast.self)
    //        for podcast in podcasts {
    //            print("title \(podcast.title)")
    //            print("audio: \(podcast.audio)")
    //            if let dialog = podcast.dialog {
    //                print("dialog: \(dialog)")
    //            }
    //        }
    //    }catch{
    //        print("cloud not query DataStore: \(error)")
    //    }
    //}
    //
    //func deleteItems() async {
    //    do {
    //        let items = try await Amplify.DataStore.query(Podcast.self,
    //                                                      where: Podcast.keys.title.eq("quel est votre..?"))
    //        guard items.count == 2, let toDeleteItem = items.first else {
    //            print("Did not find exactly one todo, bailing")
    //            return
    //        }
    //        try await Amplify.DataStore.delete(toDeleteItem)
    //        print("Deleted item: \(toDeleteItem.title)")
    //    } catch {
    //        print("Unable to perform operation: \(error)")
    //    }
    //
    //}
    
    //func subscribePodcasts() async {
    //  do {
    //      let mutationEvents = Amplify.DataStore.observe(Podcast.self)
    //      for try await mutationEvent in mutationEvents {
    //          print("Subscription got this value: \(mutationEvent)")
    //          do {
    //              let podcast = try mutationEvent.decodeModel(as: Podcast.self)
    //
    //              switch mutationEvent.mutationType {
    //              case "create":
    //                  print("Created: \(podcast)")
    //              case "update":
    //                  print("Updated: \(podcast)")
    //              case "delete":
    //                  print("Deleted: \(podcast)")
    //              default:
    //                  break
    //              }
    //          } catch {
    //              print("Model could not be decoded: \(error)")
    //          }
    //      }
    //  } catch {
    //      print("Unable to observe mutation events")
    //  }
    //}
    
    
    

