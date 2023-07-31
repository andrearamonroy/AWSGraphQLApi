////
////  AudioManager.swift
////  FrenchApp
////
////  Created by Andrea on 6/11/23.
//
//
import Foundation
import AVFoundation
import Amplify
import AWSS3StoragePlugin
import Combine

@MainActor
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
//    @Published var sliderValue: Double = 0.0
//    private var timeObserver: Any?
    
    
    
    func playAudio(withURL url: URL) {
        if player == nil || !isPlaying {
            player = AVPlayer(url: url)
            player?.seek(to: currentTime)
            player?.play()
            isPlaying = true
            //observePlaybackTime()
            
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
    


}


class AudioURLManager {
    func getUrl(audioKey: String) async throws -> URL {
            do {
                let url = try await Amplify.Storage.getURL(
                    key: audioKey, // Replace with your audio variable from DynamoDB
                    options: .init(
                        pluginOptions: AWSStorageGetURLOptions(
                            validateObjectExistence: true
                        )
                    )
                )
                return url
            } catch {
                throw error
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
        Task {
            do{
                let url = try await audioURLManager.getUrl(audioKey: audioKey)
                DispatchQueue.main.async {
                    self.audioURL = url
                }
            } catch {
                print("Failed to get the URL: \(error)")
            }
        }
    }
}



