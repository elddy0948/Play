import Foundation

protocol FollowersRepository {
  @discardableResult
  func fetchFollowerList(
    query: FollowerQuery,
    page: Int,
    cached: @escaping (FollowersPage) -> Void,
    completion: @escaping (Result<FollowersPage, Error>) ->Void
  ) -> Cancelable?
}
