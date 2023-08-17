//
//  AudioManager.swift
//  FrenchApp
//
//  Created by Andrea on 6/11/23.


import Foundation
import AVFoundation
import Amplify
import Combine
import AWSS3StoragePlugin


@MainActor // to ensure safe concurrency on the main thread.
class AudioPlayer: NSObject, ObservableObject {
    var player: AVPlayer?
    var currentTime: CMTime = .zero //CMTime Core Media Time is a data struc in Core Media framework
    //precise representation of time intervals for audio and video playback. set to .zero so audio starts at the beginning
    
    @Published var isPlaying: Bool = false
    
    @Published var playbackSpeed: Float = 1.0 {
            didSet {
                player?.rate = playbackSpeed
            }
        }
    
    //slider
   // @Published var sliderValue: Double = 0.0
    private var timeObserver: Any? //to track playback time
    @Published var playbackProgress: Double = 0.0 //represents playback process
    
    
    
    func playAudio(withURL url: URL) {
        if player == nil || !isPlaying { //if player is not currently playing or init, it inits it
            player = AVPlayer(url: url)
            player?.seek(to: currentTime)
            player?.play()
            isPlaying = true
            observePlaybackTime() //calls observePlaybackTime to track the playback progress
            
           // player?.currentItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)

            
        }
    }
    
    func pauseAudio() {
        if let player = player {
            currentTime = player.currentTime() //store current time
            player.pause()  //pause player
            isPlaying = false  //update isPlaying to false
        }
    }
    
    func stopAudio() {
        if let player = player {
            player.pause() //pause player
            player.replaceCurrentItem(with: nil) //removes the current item from the player
            currentTime = .zero //resets the playback time to zero
            isPlaying = false  //updates the isPlaying to false
        }
    }
    
    func togglePlayback(withURL url: URL) { //toggles between playing and pausing the audio
        if isPlaying {
            pauseAudio()
        } else {
            playAudio(withURL: url)
        }
    }
    func seekBackward() {
        guard let player = player else { return }
        let currentTime = player.currentTime() //currentTime is assigned player.currentime() methos so it gets the current position of the audio
        let backwardTime = CMTime(seconds: 10, preferredTimescale: 1) //interval of 10 secs time scale of 1 means that the intervals are whole seconds
        let newTime = currentTime - backwardTime //new time calculated by substracting 10
        
        let totalTime = player.currentItem?.duration.seconds ?? 0
        let newProgress = (newTime.seconds) / totalTime
        
        player.seek(to: newTime, toleranceBefore: .zero, toleranceAfter: .zero) //(target is the time to seek) new time and trolerance before and after is set to zero so it needs to be as accurate as possible
        playbackProgress = newProgress // Update the playbackProgress
    }
    
    func seekForward() {
        guard let player = player else { return }
        let currentTime = player.currentTime()
        let forwardTime = CMTime(seconds: 10, preferredTimescale: 1)
        let newTime = currentTime + forwardTime

        let totalTime = player.currentItem?.duration.seconds ?? 0
        let newProgress = (newTime.seconds) / totalTime
        
        player.seek(to: newTime, toleranceBefore: .zero, toleranceAfter: .zero)
        
        playbackProgress = newProgress // Update the slider value
    }

    
    //slider
    func observePlaybackTime() {
        guard let player = player else { return }

        // Observe playback time
        let interval = CMTime(seconds: 1.0, preferredTimescale: 1) //this closure in addperiodTimeObeserved is called every second
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self else { return } //This line is used within the closure to safely capture self as an optional weak reference, If self is nil (which can happen if the instance has been deallocated), the closure returns early to avoid using a nil reference.
            let totalTime = player.currentItem?.duration.seconds ?? 0 //currentItem is the media being played and the duration gets the total duration in secs. if theres no valid duration so curreItem is nil, default to 0
            let currentTime = time.seconds //represents current playback and gets seconds
            self.playbackProgress = currentTime / totalTime //calculates playback progrss as a fraction. divides the current time and total time gives a value between 0.0/0.1 this is assinged to @Published playbackPorgess
            
            /*Overall, the observePlaybackTime() function sets up a time observer that periodically updates the playbackProgress property based on the current playback time and the total duration of the media being played*/
        }
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "status", let statusValue = change?[.newKey] as? Int, let status = AVPlayer.Status(rawValue: statusValue) {
//            if status == .readyToPlay {
//                // Playback finished, reset slider and update UI
//                resetSlider()
//            }
//        }
//    }
//
//    func resetSlider() {
//        DispatchQueue.main.async {
//            self.playbackProgress = 0.0
//        }
//    }
    
    func seekToBeginningAndPause() {
        guard let player = player else { return }
        let newTime = CMTime.zero

        player.seek(to: newTime, toleranceBefore: .zero, toleranceAfter: .zero)
        player.pause()

        isPlaying = false
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
