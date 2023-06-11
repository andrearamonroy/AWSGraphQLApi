//
//  PodcastViewModel.swift
//  FrenchApp
//
//  Created by Andrea on 5/22/23.
//

import Foundation
import SwiftUI
import Amplify
import Combine
import class Amplify.List

class ProductionDataService  {
    //singleton
    //static let singleton = ProductionDataService()

    func getData() -> AnyPublisher<Result<List<Podcast>, GraphQLResponseError<List<Podcast>>>, any Error> {
        
      Amplify.Publisher.create {
            try await Amplify.API.query(
                request: GraphQLRequest<Podcast>.list(Podcast.self))
            
      }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }

}
class PodcastViewModel : ObservableObject {
    @Published var podcasts: [Podcast] = []
    var cancellables = Set<AnyCancellable>() //init a new one
    let dataService: ProductionDataService
    //  private let audioPlayer: AudioPlayerProtocol
    
    init(dataService: ProductionDataService ){
        self.dataService = dataService
        // self.audioPlayer = audioPlayer
        
        loadData()
    }
    
    func loadData(){
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] result in
                switch result {
                case .success(let podcasts):
                    self?.podcasts.append(contentsOf: podcasts)
                    
                case .failure(let error):
                    print("Failed to retrieve podcasts: \(error)")
                }
            }
            .store(in: &cancellables)
        
    }
}

    
    
    
    //
    //class PodcastViewModel : ObservableObject {
    //    @Published var podcasts: [Podcast] = [] //holds models
    //    var hasFetchedPodcasts = false
    //
    //
    //    func getPodcast() async {
    //        // or hasFetchedPodcasts == false
    //        guard !hasFetchedPodcasts else {
    //                return //if true return (exit early of the func)
    //            }
    //        //if false execute do block
    //
    //        do {
    //            let result = try await Amplify.API.query(
    //                request: GraphQLRequest<Podcast>.list(Podcast.self)
    //            )
    //
    //            switch result {
    //            case .success(let podcast):
    //                await MainActor.run(body: {
    //
    //                    self.podcasts.append(contentsOf: podcast)
    //                    self.hasFetchedPodcasts = true
    //                })
    //
    //                print("Successfully retrieved todo: \(podcast)")
    //
    //            case .failure(let error):
    //                print("Got failed result with \(error.errorDescription)")
    //            }
    //        } catch let error as APIError {
    //            print("Failed to query podcast: ", error)
    //        } catch {
    //            print("Unexpected error: \(error)")
    //        }
    //    }
    //
    //}
    

