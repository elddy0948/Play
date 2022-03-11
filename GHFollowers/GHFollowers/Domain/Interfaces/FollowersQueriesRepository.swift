import Foundation

protocol FollowersQueriesRepository {
  func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[FollowerQuery], Error>) -> Void)
  func saveRecentQuery(_ query: FollowerQuery, completion: @escaping (Result<FollowerQuery, Error>) -> Void)
}
