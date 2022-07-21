import Foundation

final class DefaultFollowersRepository {
  private let dataTransferService: DataTransferService
  
  init(dataTransferService: DataTransferService) {
    self.dataTransferService = dataTransferService
  }
}

extension DefaultFollowersRepository: FollowersRepository {
  func fetchFollowerList(
    query: FollowerQuery,
    page: Int,
    cached: @escaping (FollowersPage) -> Void,
    completion: @escaping (Result<FollowersPage, Error>) -> Void
  ) -> Cancelable? {
    let requestDTO = FollowersRequestDTO(
      query: "",
      page: 1
    )
    
    let task = RepositoryTask()
    
    let endpoint = APIEndpoints.getFollowers(with: "elddy0948")
    
    task.networkTask = self.dataTransferService.request(
      with: endpoint, completion: { result in
        switch result {
        case .success(let responseDTO):
          completion(.success(responseDTO.toDomain()))
        case .failure(let error):
          completion(.failure(error))
        }
      })
    
    return task
  }
}

