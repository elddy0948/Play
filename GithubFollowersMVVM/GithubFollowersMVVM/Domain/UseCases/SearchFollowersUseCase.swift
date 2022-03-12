import Foundation

protocol SearchFollowersUseCase {
  func execute(
    username: String,
    completion: @escaping (Result<[Follower], Error>) -> Void
  )
}

final class DefaultSearchFollowersUseCase {
  //MARK: - Repository
  private let followersRepository: FollowersRepository
  
  init(followersRepository: FollowersRepository) {
    self.followersRepository = followersRepository
  }
}

extension DefaultSearchFollowersUseCase: SearchFollowersUseCase {
  func execute(username: String,
               completion: @escaping (Result<[Follower], Error>) -> Void) {
    followersRepository.fetchFollowersList(
      username: username,
      completion: { result in
        switch result {
        case .success(let followers):
          completion(.success(followers))
        case .failure(let error):
          completion(.failure(error))
        }
      })
  }
}
