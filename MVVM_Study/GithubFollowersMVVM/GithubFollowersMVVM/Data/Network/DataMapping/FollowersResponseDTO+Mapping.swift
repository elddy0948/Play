import Foundation

struct FollowersResponseDTO: Decodable {
  let followers: [FollowerDTO]
}

struct FollowerDTO: Decodable {
  private enum CodingKeys: String, CodingKey {
    case login
    case avatarURL = "avatar_url"
  }
  
  let login: String
  let avatarURL: String?
}

//MARK: - Mappings to Domain
extension FollowersResponseDTO {
  func toDomain() -> Followers {
    return .init(followers: followers.map({ $0.toDomain() }))
  }
}

extension FollowerDTO {
  func toDomain() -> Follower {
    return .init(login: login, avatarURL: avatarURL)
  }
}
