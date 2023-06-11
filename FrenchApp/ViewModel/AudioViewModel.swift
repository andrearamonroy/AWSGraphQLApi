//
//  AudioViewModel.swift
//  FrenchApp
//
//  Created by Andrea on 5/30/23.
//

import Foundation

final class AudioViewModel: ObservableObject {
    
    private(set) var audio: Podcast
    
    init(audio: Podcast) {
        self.audio = audio
    }
}
