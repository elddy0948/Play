import Foundation

struct FollowersResponseDTO: Decodable {
  let page: Int
  let followers: [FollowerDTO]
}

extension FollowersResponseDTO {
  struct FollowerDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
      case login
      case avatarURL = "avatar_url"
    }
    
    let login: String
    let avatarURL: String
  }
}

//MARK: - Mappings to Domain
extension FollowersResponseDTO {
  func toDomain() -> FollowersPage {
    return .init(page: page,
                 followers: followers.map({$0.toDomain()}))
  }
}

extension FollowersResponseDTO.FollowerDTO {
  func toDomain() -> Follower {
    return .init(login: login, avatarURL: avatarURL)
  }
}
