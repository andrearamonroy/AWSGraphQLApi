//
//  SpeechToTextVM.swift
//  FrenchApp
//
//  Created by Andrea on 6/21/23.
//

import Foundation
import Amplify
import Combine

import Combine

import Combine

//class SpeechToTextConverter {
//    private var cancellables = Set<AnyCancellable>()
//
//    func convertSpeechToText(url: URL) -> AnyPublisher<[String], Error> {
//        let subject = PassthroughSubject<[String], Error>()
//
//        let options = Predictions.Convert.SpeechToText.Options(
//            defaultNetworkPolicy: .auto,
//            language: .french
//        )
//
//        Amplify.Predictions.convert(.speechToText(url: url), options: options) { event in
//            // Code inside the closure
//
//
//            switch event {
//            case .success(let result):
//                let transcription = result.transcription.map(\.fullText)
//                subject.send(transcription)
//                subject.send(completion: .finished)
//            case .failure(let error):
//                subject.send(completion: .failure(error))
//            }
//        }
//        .store(in: &cancellables)
//
//        return subject.eraseToAnyPublisher()
//    }
//}
//
//
//class SpeechToTextVM: ObservableObject {
//    @Published var transcriptionParts: [String] = []
//    var cancellables = Set<AnyCancellable>()
//    var speechToTextManager : SpeechToTextManager
//
//    init(speechToTextManager : SpeechToTextManager){
//        self.speechToTextManager = speechToTextManager
//    }
//
//    func loadSpeechToText(url : URL){
//        speechToTextManager.convertSpeechToText(url: url)
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    DispatchQueue.main.async {
//                        print("Failed to get the URL: \(error)")
//                    }
//                }
//            } receiveValue: { [weak self] transcriptionPart in
//                self?.transcriptionParts.append(transcriptionPart)
//                print("Transcription part: \(transcriptionPart)")
//            }
//            .store(in: &cancellables)
//    }
//
//}
