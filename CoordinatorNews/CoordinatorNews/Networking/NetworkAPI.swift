import Foundation
import RxSwift

class NetworkAPI {
  private let baseURL = "https://newsapi.org/v2/top-headlines"
  
  static let shared = NetworkAPI()
  
  private init() { }
  
  func fetchHeadLines() -> Observable<NewsResponse> {
    guard let url = createURL() else {
      return Observable.error(NetworkError.invalidRequest)
    }
    let request = URLRequest(url: url)
    
    return URLSession.shared.rx
      .toDecodable(request: request, type: NewsResponse.self)
  }
  
  private func createURL() -> URL? {
    guard var urlComponents = URLComponents(string: baseURL) else {
      return nil
    }
    
    urlComponents.queryItems = [
      URLQueryItem(name: "country", value: "us"),
      URLQueryItem(name: "apiKey", value: Privacy.apiKey.rawValue),
    ]
    
    return urlComponents.url
  }
}
