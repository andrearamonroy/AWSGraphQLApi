// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "253a1f7b41f010c39e68e72a73d9f22f"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Podcast.self)
    ModelRegistry.register(modelType: Episode.self)
  }
}