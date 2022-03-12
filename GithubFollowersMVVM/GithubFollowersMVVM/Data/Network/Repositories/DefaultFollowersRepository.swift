import Foundation

final class DefaultFollowersRepository {
  //Network Service
  private let urlString: String
  
  init(urlString: String) {
    self.urlString = urlString
  }
}

extension DefaultFollowersRepository: FollowersRepository {
  func fetchFollowersList(
    username: String,
    completion: @escaping (Result<[Follower], Error>) -> Void
  ) {
    guard let url = URL(string: urlString + "/\(username)/followers") else {
      return
    }
    
    let task = URLSession.shared.dataTask(
      with: url,
      completionHandler: { (data, response, error) in
        if let error = error {
          completion(.failure(error))
          return
        }
        
        guard let response = response,
              let httpResponse = response as? HTTPURLResponse,
              (200 ..< 300) ~= httpResponse.statusCode else {
                return
              }
        
        guard let data = data else {
          return
        }
        
        do {
          let followers = try JSONDecoder().decode([FollowerDTO].self, from: data)
          completion(.success(followers.map({ $0.toDomain() })))
        } catch {
          return
        }
      })
    
    task.resume()
  }
}
