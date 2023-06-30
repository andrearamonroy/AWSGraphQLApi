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
    var player: AVPlayer?
    var currentTime: CMTime = .zero
    
    @Published var isPlaying: Bool = false
    
    @Published var playbackSpeed: Float = 1.0 {
            didSet {
                player?.rate = playbackSpeed
            }
        }
    
    //slider
    @Published var sliderValue: Double = 0.0
    private var timeObserver: Any?
    
    
    
    func playAudio(withURL url: URL) {
        if player == nil || !isPlaying {
            player = AVPlayer(url: url)
            player?.seek(to: currentTime)
            player?.play()
            isPlaying = true
            
        }
    }
    
    func pauseAudio() {
        if let player = player {
            currentTime = player.currentTime()
            player.pause()
            isPlaying = false
        }
    }
    
    func stopAudio() {
        if let player = player {
            player.pause()
            player.replaceCurrentItem(with: nil)
            currentTime = .zero
            isPlaying = false
        }
    }
    
    func togglePlayback(withURL url: URL) {
        if isPlaying {
            pauseAudio()
        } else {
            playAudio(withURL: url)
        }
    }
    func seekBackward() {
        guard let player = player else { return }
        let currentTime = player.currentTime()
        let backwardTime = CMTime(seconds: 10, preferredTimescale: 1)
        let newTime = currentTime - backwardTime
        player.seek(to: newTime, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    func seekForward() {
        guard let player = player else { return }
        let currentTime = player.currentTime()
        let forwardTime = CMTime(seconds: 10, preferredTimescale: 1)
        let newTime = currentTime + forwardTime
        player.seek(to: newTime, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    //slider
    private func observePlaybackTime() {
            guard let player = player else { return }
            
            timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: 1), queue: .main) { [weak self] time in
                guard let self = self else { return }
                let duration = player.currentItem?.duration ?? .zero
                let progress = time.seconds / duration.seconds * 100
                self.sliderValue = progress
            }
        }
        
        private func removeTimeObserver() {
            if let observer = timeObserver {
                player?.removeTimeObserver(observer)
                timeObserver = nil
            }
        }

}


class AudioURLManager {
    func getUrl(audioKey: String) ->   Future<URL, Error> {
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
}


