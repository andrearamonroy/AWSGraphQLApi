// swiftlint:disable all
import Amplify
import Foundation

extension Podcast {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case level
    case episodes
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let podcast = Podcast.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Podcasts"
    
    model.attributes(
      .primaryKey(fields: [podcast.id])
    )
    
    model.fields(
      .field(podcast.id, is: .required, ofType: .string),
      .field(podcast.level, is: .required, ofType: .string),
      .hasMany(podcast.episodes, is: .optional, ofType: Episode.self, associatedWith: Episode.keys.podcastID),
      .field(podcast.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(podcast.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Podcast: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}