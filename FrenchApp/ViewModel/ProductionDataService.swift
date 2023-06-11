//
//  ProductionDataService.swift
//  FrenchApp
//
//  Created by Andrea on 5/22/23.
//

import Foundation
import SwiftUI
import Amplify
import Combine

//protocol PodcastAPIService {
//    func fetchPodcast() -> AnyCancellable
//
//}
//
//class ProductionDataService: PodcastAPIService {
//    func fetchPodcast() -> AnyCancellable {
//        let sink = Amplify.Publisher.create {
//            try await Amplify.API.query(
//                request: .get(Podcast.self, byId: "9FCF5DD5-1D65-4A82-BE76-42CB438607A0")
//            )
//        }
//        .sink {
//            if case let .failure(error) = $0 {
//                print("Got failed event with error \(error)")
//            }
//        }
//        receiveValue: { result in
//            switch result {
//            case .success(let todo):
//                guard let todo = todo else {
//                    print("Could not find todo")
//                    return
//                }
//                print("Successfully retrieved todo: \(todo)")
//            case .failure(let error):
//                print("Got failed result with \(error.errorDescription)")
//            }
//        }
//        return sink
//    }
//    }
    



