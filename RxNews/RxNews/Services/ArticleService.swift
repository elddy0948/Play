import Foundation
import RxSwift

enum ArticleServiceError: Error {
  case invalidRequest
  
  var message: String {
    switch self {
    case .invalidRequest:
      return "요청에 실패했습니다."
    }
  }
}

final class ArticleService {
  
  static let shared = ArticleService()
  
  private init() { }
  
  let baseURL = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=\(Privacy.myApiKey)"
  
  private func buildRequest() -> URLRequest? {
    guard var urlComponents = URLComponents(string: baseURL) else { return nil }
    urlComponents.queryItems = [
      URLQueryItem(name: "q", value: "bitcoin"),
      URLQueryItem(name: "apiKey", value: Privacy.myApiKey),
      URLQueryItem(name: "pageSize", value: "50"),
      URLQueryItem(name: "page", value: "1")
    ]
    
    guard let url = urlComponents.url else { return nil }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    return request
  }
  
  func fetchArticles() -> Observable<ArticleResponse> {
    guard let request = buildRequest() else {
      return Observable.error(ArticleServiceError.invalidRequest)
    }
    
    return URLSession.shared.rx
      .decodable(request: request, type: ArticleResponse.self)
  }
}
