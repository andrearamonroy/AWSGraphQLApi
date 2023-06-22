//
//  AudioManager.swift
//  FrenchApp
//
//  Created by Andrea on 6/11/23.


import Foundation
import AVFoundation
import Amplify
import AWSS3StoragePlugin
import Combine


class AudioPlayer: NSObject, ObservableObject {
    private var player: AVPlayer?

    func playAudio(withURL url: URL) {
        player = AVPlayer(url: url)
        player?.play()
    }

    func stopAudio() {
        player?.pause()
    }
}

class AudioURLManager {
    func getUrl(audioKey: String) -> Future<URL, Error> {
        Future { promise in
            Task {
                do {
                    let url = try await Amplify.Storage.getURL(
                        key: audioKey, // Replace with your audio variable from DynamoDB
                        options: .init(
                            pluginOptions: AWSStorageGetURLOptions(
                                validateObjectExistence: true
                            )
                        )
                    )
                    promise(.success(url))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    
    }
       
}

class AudioVM: ObservableObject {
    @Published var audioURL: URL?
    var audioURLManager: AudioURLManager
    var cancellables = Set<AnyCancellable>()
    
    init(audioURLManager: AudioURLManager) {
        self.audioURLManager = audioURLManager
    }
    
    func loadAudio(audioKey: String) {
        audioURLManager.getUrl(audioKey: audioKey)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("Failed to get the URL: \(error)")
                    }
                }
            } receiveValue: { url in
                DispatchQueue.main.async {
                    self.audioURL = url
                }
            }
            .store(in: &cancellables)
    }
    
    func speechToText(audioURL: URL) async throws {
        let options = Predictions.Convert.SpeechToText.Options(
            defaultNetworkPolicy: .auto,
            language: .usEnglish
        )

        let result = try await Amplify.Predictions.convert(
            .speechToText(url: audioURL), options: options
        )

        let transcription = result.map(\.transcription)

        for try await transcriptionPart in transcription {
            print("transcription part: \(transcriptionPart)")
        }
    }
}


