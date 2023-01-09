import Foundation

final class NetworkService {
  @Published var xkcdResponse: XkcdResponseDTO?
  
  private let baseURL = "https://xkcd.com/"
  private let lastPathComponent = "/info.0.json"
  
  private let session: URLSession
  private let sessionConfiguration: URLSessionConfiguration
  
  init(session: URLSession, sessionConfiguration: URLSessionConfiguration) {
    self.session = session
    self.sessionConfiguration = sessionConfiguration
  }
  
  func fetch(num: Int) async {
    guard let destinationURL = URL(string: baseURL + "\(num)" + lastPathComponent) else {
      return
    }
    
    guard let (data, response) = try? await session.dataTask(from: destinationURL) else {
      return
    }
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200 ..< 300) ~= httpResponse.statusCode else {
      return
    }
    
    do {
      let xkcd = try JSONDecoder().decode(XkcdResponseDTO.self, from: data)
      xkcdResponse = xkcd
      print(xkcd.title)
    } catch {
      print(error)
    }
  }
}
