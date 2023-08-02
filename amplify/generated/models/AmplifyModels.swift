// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "6a05745fed6922dfabf74c16ce53bbde"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Podcast.self)
  }
}