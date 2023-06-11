//
//  APIMutation.swift
//  FrenchApp
//
//  Created by Andrea on 5/26/23.
//

import Foundation
import Amplify

//func createPodcast() async {
//    // Retrieve your Todo using Amplify.API.query
//    var podcast = Podcast(title: "Les verbes en -er", audio: "verbesER.mp3", dialog: [
//        Dialog(speakerFrench1: "Chloé: Qu’est-ce que tu regardes?",
//               speakerEnglish1: "Chloe: What are you looking at?",
//               speakerFrench2: "Vincent: Je regarde un film en allemand.",
//               speakerEnglish2: "Vincent: I’m watching a movie in German.",
//               speakerFrench3: "Chloé: Ah bon? Tu parles allemand?",
//               speakerEnglish3: "Chloe: What? You speak German?",
//               speakerFrench4: "Vincent: Oui, j’étudie l’allemand depuis deux ans. Je travaille avec des Allemands. Alors, je communique avec eux en allemand ou en anglais.",
//               speakerEnglish4: "Vincent: Yes, I’ve been studying German for two years. I work with Germans. So I communicate with them in German or English."),
//    Dialog(speakerFrench1: "Chloé: Tu ne trouves pas ça difficile?",
//           speakerEnglish1: "Chloe: Don’t you find that difficult?",
//           speakerFrench2: "Vincent: Je pense que l’allemand est difficile au début. Mais, j’utilise une bonne méthode.",
//           speakerEnglish2: "Vincent: I think German is difficult at first. But I use a good method.",
//           speakerFrench3: "Chloé: Ah oui? Tu utilises quelle méthode?",
//           speakerEnglish3: "Chloe: Oh yeah? What method do you use?",
//           speakerFrench4: "Vincent: J’écoute des dialogues tous les jours.",
//           speakerEnglish4: "Vincent: I listen to dialogs every day."),
//    Dialog(speakerFrench1: "Chloé: Et c’est efficace?",
//           speakerEnglish1: "Chloe: And it works?",
//           speakerFrench2: "Vincent: Oui, ça marche bien. Je mémorise aussi des listes de vocabulaire.",
//           speakerEnglish2: "Vincent: Yes, it works well. I also memorize vocabulary lists.",
//           speakerFrench3: "Chloé: Oui, alors là, non merci. Je n’aime pas du tout mémoriser les listes!",
//           speakerEnglish3: "Chloe: Yes, then, no thank you. I don’t like memorizing lists at all!",
//           speakerFrench4: "",
//           speakerEnglish4: "")])
//
//
//
//    do {
//        let result = try await Amplify.API.mutate(request: .create(podcast))
//        switch result {
//        case .success(let todo):
//            print("Successfully created todo: \(todo)")
//        case .failure(let error):
//            print("Got failed result with \(error.errorDescription)")
//        }
//    } catch let error as APIError {
//        print("Failed to update todo: ", error)
//    } catch {
//        print("Unexpected error: \(error)")
//    }
//}
