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
  
  func buildRequest() -> URLRequest? {
    guard let url = URL(string: baseURL) else { return nil }
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
