//
//  EpisodeViewModel.swift
//  FrenchApp
//
//  Created by Andrea on 8/4/23.
//

import Foundation
import Combine
import Amplify
import class Amplify.List

class EpisodeDataService {
    

    
    func getData(id: String) -> AnyPublisher<Result<List<Episode>, GraphQLResponseError<List<Episode>>>, any Error> {
        
      Amplify.Publisher.create {
            try await Amplify.API.query(
                request: GraphQLRequest<Episode>.list(Episode.self))
            
      }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }
    
   

}

class EpisodeVM : ObservableObject {
    @Published var episodes: [Episode] = []
    let podcast : Podcast
    var cancellables = Set<AnyCancellable>()
    let dataService: EpisodeDataService
    
    
    init(podcast: Podcast ) {
        self.dataService = EpisodeDataService()
        self.podcast = podcast
        loadData()
    }
    
    func loadData(){
        dataService.getData(id: podcast.id)
            .sink { _ in
              
            } receiveValue: { [weak self] result in
                switch result {
                case .success(let episode):
                   
                        self?.episodes.append(contentsOf: episode)
                  
                    print("success podcasts")
                
                case .failure(let error):
                    print("Failed to retrieve podcasts: \(error)")
                }
            }
            .store(in: &cancellables)

    }
    
   
}
