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
//import AWSS3StoragePlugin

class AudioManager {
    
    func getAudio(audioKey: String) -> AnyPublisher<Data, StorageError> {
        
        let downloadTask = Amplify.Storage.downloadData(key: audioKey)
            .inProcessPublisher
            .flatMap { progress -> AnyPublisher<Data, StorageError> in
                // Handle progress updates if needed
                print("Progress: \(progress)")
                
                // Return a placeholder value or handle progress updates
                return Empty<Data, StorageError>().eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        return downloadTask
    }
    
}


class AudioVM: ObservableObject {
    @Published var audioPlayer: AVAudioPlayer?
    let audioManager: AudioManager
    var cancellables = Set<AnyCancellable>()
    
    init(audioManager: AudioManager) {
        self.audioManager = audioManager
    }
    
    func loadAudio(audioKey: String) {
        audioManager.getAudio(audioKey: audioKey)
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Failed: \(error.localizedDescription)")
                    }
                },
                receiveValue: { [weak self] audioData in
                    self?.playAudio(data: audioData)
                }
            )
            .store(in: &cancellables)
    }
    
    func playAudio(data: Data) {
        do {
            audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer?.play()
        } catch {
            print("Failed to create audio player: \(error.localizedDescription)")
        }
    }
}
