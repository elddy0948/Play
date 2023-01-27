import Combine
import Foundation

final class NetworkService {
  
  enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case invalidStatusCode(code: Int, data: Data)
  }
  
  private let session: URLSession
  
  init(
    session: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
  ) {
    self.session = session
  }
  
  func load<T>(
    _ resource: Resource<T>
  ) -> AnyPublisher<T, Error> {
    guard let request = resource.request else {
      return Fail(error: NetworkError.invalidRequest)
        .eraseToAnyPublisher()
    }
    
    return session.dataTaskPublisher(for: request)
      .mapError({ _ in return NetworkError.invalidRequest})
      .print()
      .flatMap({ data, response -> AnyPublisher<Data, Error> in
        guard let response = response as? HTTPURLResponse else {
          return Fail(error: NetworkError.invalidResponse)
            .eraseToAnyPublisher()
        }
        
        guard (200 ..< 300) ~= response.statusCode else {
          return Fail(error: NetworkError.invalidStatusCode(
            code: response.statusCode,
            data: data))
          .eraseToAnyPublisher()
        }
        
        return Just(data)
          .catch({ _ in
            Empty<Data, Error>().eraseToAnyPublisher()
          })
            .eraseToAnyPublisher()
      })
      .decode(type: T.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
