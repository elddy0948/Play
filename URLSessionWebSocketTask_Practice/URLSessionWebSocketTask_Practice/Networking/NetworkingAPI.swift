import Foundation


struct NetworkingAPI {
  static let shared = NetworkingAPI()
  
  func createSession(url: URL) -> URLSessionWebSocketTask {
    let session = URLSession(configuration: .default)
    let webSocketTask = session.webSocketTask(with: url)
    return webSocketTask
  }
  
  
}
