import Foundation

struct FollowersRequestDTO: Encodable {
  let query: String
  let page: Int
}
