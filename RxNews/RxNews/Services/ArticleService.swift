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
  let cache: ArticleResponse = .empty
  
  private init() { }
  
  let baseURL = "https://newsapi.org/v2/everything"
  
  private func buildRequest() -> URLRequest? {
    guard var urlComponents = URLComponents(string: baseURL) else { return nil }
    urlComponents.queryItems = [
      URLQueryItem(name: "q", value: "bitcoin"),
      URLQueryItem(name: "apiKey", value: Privacy.myApiKey),
      URLQueryItem(name: "pageSize", value: "10"),
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
      .catch({ [weak self] error in
        guard let self = self else { return .empty() }
        return Observable.just(self.cache)
      })
  }
}
