// swiftlint:disable all
import Amplify
import Foundation

public struct Podcast: Model {
  public let id: String
  public var level: String
  public var episodes: List<Episode>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      level: String,
      episodes: List<Episode>? = []) {
    self.init(id: id,
      level: level,
      episodes: episodes,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      level: String,
      episodes: List<Episode>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.level = level
      self.episodes = episodes
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}