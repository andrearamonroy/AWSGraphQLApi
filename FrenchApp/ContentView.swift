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


struct ContentView: View {
    @StateObject private var vm : PodcastViewModel
    
    init(dataService: ProductionDataService) {
          _vm = StateObject(wrappedValue: PodcastViewModel(dataService: dataService))
       }

    var body: some View {

        NavigationView {
            List {
                ForEach(vm.podcasts, id: \.id) { podcast in
                    NavigationLink(destination: DialogView(dialog: podcast.dialog)) {
                        Text(podcast.title)
                        Text(podcast.audio)
                    }
                }
            }
       }
    }
}

struct DialogView: View {
    var dialog: [String]
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
        }
    }
}










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





    
    
    
    
    
    
    
    
    //func createTodo() async {
    //    var podcast = Podcast(title: "Le verbe avoir", audio: "verbeAvoir.mp3",
    //                          dialog: ["Jeanne: Vous avez des carottes?", "Le marchand: Oui, j’ai des carottes. Un kilo?",
    //                                  "Jeanne : Oui, un kilo, s’il vous plaît.","Le marchand: Autre chose?","Jeanne: Oui, vous avez des melons?","Le marchand: J’ai des melons de Charentes.","Jeanne: Alors, trois melons, s’il vous plaît.", "Le marchand: Trois melons.","Jeanne: Et deux kilos de pommes de terre. C’est tout.", "Le marchand: Alors, un kilo de carottes, trois melons et deux kilos de pommes de terre. Douze euros trente.","Jeanne: Tenez!","Le marchand: Merci, bonne journée."])
    //    do {
    //        let result = try await Amplify.API.mutate(request: .create(podcast))
    //        switch result {
    //        case .success(let podcast):
    //            print("Successfully created the podcast: \(podcast)")
    //        case .failure(let graphQLError):
    //            print("Failed to create graphql \(graphQLError)")
    //        }
    //    } catch let error as APIError {
    //        print("Failed to create a podcast: ", error)
    //    } catch {
    //        print("Unexpected error: \(error)")
    //    }
    //}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //
    //func performOnAppear() async {
    //    do {
    //       let item = Podcast(title: "quel est votre..?", audio: "d0.mp3",
    //                          dialog: [Dialog(speakerFrench1: "La secrétaire: Quel est votre nom de famille?",
    //                                          speakerEnglish1: "The secretary: What is your last name?",
    //                                          speakerFrench2: "Georges: Dupont. D.U.P.O.N.T",
    //                                          speakerEnglish2: "Georges: Dupont. D.U.P.O.N.T",
    //                                          speakerFrench3: "La secrétaire: Quel est votre prénom?",
    //                                          speakerEnglish3: "The secretary: What is your first name?",
    //                                          speakerFrench4: "Georges: Georges. G.E.O.R.G.E.S",
    //                                          speakerEnglish4: "Georges: Georges. G.E.O.R.G.E.S"),
    //                          Dialog(speakerFrench1: "La secrétaire: Quelle est votre nationalité?",
    //                                 speakerEnglish1: "The secretary: What is your nationality?",
    //                                 speakerFrench2: "Georges: Je suis canadien.",
    //                                 speakerEnglish2: "Georges: I am Canadian.",
    //                                 speakerFrench3: "La secrétaire: Quelle est votre profession?",
    //                                 speakerEnglish3: "The secretary: What is your profession?",
    //                                 speakerFrench4: "Georges: Je suis journaliste. ",
    //                                 speakerEnglish4: "Georges: I’m a journalist."),
    //                          Dialog(speakerFrench1: "La secrétaire: Merci. Quelle est votre adresse e-mail? ",
    //                                 speakerEnglish1: "The secretary: Thank you. What is your e-mail address? ",
    //                                 speakerFrench2: "Georges: C’est georgesd arobase caramel point com",
    //                                 speakerEnglish2: "Georges: It’s georgesd@caramel.com",
    //                                 speakerFrench3: "La secrétaire: Merci. Quel est votre numéro de téléphone? ",
    //                                 speakerEnglish3: "The secretary:Thank you.What is your phone number?",
    //                                 speakerFrench4: "Georges: C’est le zéro huit zéro zéro vingt-cinq quarante-sept quatorze.",
    //                                 speakerEnglish4: "Georges: It’s zero eight zero twenty-five forty-seven fourteen."),
    //                          Dialog(speakerFrench1: "La secrétaire: Merci beaucoup.",
    //                                 speakerEnglish1: "The secretary: Thank you very much.",
    //                                 speakerFrench2: "", speakerEnglish2: "", speakerFrench3: "", speakerEnglish3: "", speakerFrench4: "", speakerEnglish4: "")])
    //
    //        let savedItem = try await Amplify.DataStore.save(item)
    //        print("saved item: \(savedItem.title)")
    //
    //
    //
    //    } catch {
    //        print("could not save item to DataStore \(error)")
    //    }
    //}
    //
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
    
    
    

