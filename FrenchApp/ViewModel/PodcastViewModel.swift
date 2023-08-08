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
                request: .getPodcast())
          
          //GraphQLRequest<Podcast>.list(Podcast.self)
            
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
    
    init(dataService: ProductionDataService ) {
        self.dataService = dataService
        
        loadData()
        
    }

    func loadData(){
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] result in
                switch result {
                case .success(let podcasts):
                    self?.podcasts.append(contentsOf: podcasts)
                    print("success podcasts")
                
                case .failure(let error):
                    print("Failed to retrieve podcasts: \(error)")
                }
            }
            .store(in: &cancellables)
        
    }
  
}
extension GraphQLRequest {
    static func getPodcast() -> GraphQLRequest<List<Podcast>> {
        let document = """
        query MyQuery {
          listPodcasts {
            items {
              id
              level
              episodes {
                items {
                  id
                  podcastID
                  title
                  dialog
                  audio
                }
              }
            }
          }
        }
        """
        return GraphQLRequest<List<Podcast>>(
            document: document,
            responseType: List<Podcast>.self,
            decodePath: "listPodcasts"
        )
    }
}
 


    
    
  
    

