import Foundation

protocol FollowersRepository {
  func fetchFollowersList(
    username: String,
    completion: @escaping (Result<[Follower], Error>) -> Void
  )
}
