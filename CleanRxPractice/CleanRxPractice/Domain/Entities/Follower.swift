import Foundation

public struct Follower: Decodable {
  let login: String
  let avatarURL: String?
  
  enum CodingKeys: String, CodingKey {
    case login
    case avatarURL = "avatar_url"
  }
}
