// swiftlint:disable all
import Amplify
import Foundation

public struct Podcast: Model {
  public let id: String
  public var title: String
  public var audio: String
  public var dialog: [String]
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      title: String,
      audio: String,
      dialog: [String] = []) {
    self.init(id: id,
      title: title,
      audio: audio,
      dialog: dialog,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      title: String,
      audio: String,
      dialog: [String] = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.title = title
      self.audio = audio
      self.dialog = dialog
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}