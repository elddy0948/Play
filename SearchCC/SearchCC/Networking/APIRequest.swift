import Foundation
import RxSwift
import RxCocoa

class APIRequest {
  
  static let shared = APIRequest()
  
  private let baseURL = URL(string: "https://api.coingecko.com/api/v3/coins")
  
  //MARK: - Initializer
  private init() {}
  
  func fetchCoin(name: String) -> Observable<Coin> {
    guard let request = buildRequest(pathComponent: name, params: [
      ("localization", "false"),
      ("tickers", "false"),
      ("market_data", "false"),
      ("community_data", "false"),
      ("developer_data", "false"),
      ("sparkline", "false")
    ]) else { return Observable<Coin>.empty() }
    
    return request.map { data in
      try JSONDecoder().decode(Coin.self, from: data)
    }
  }
  
  private func buildRequest(method: String = "GET", pathComponent: String, params: [(String, String)]) -> Observable<Data>? {
    guard let baseURL = baseURL else { return nil }
    let url = baseURL.appendingPathComponent(pathComponent)
    var request = URLRequest(url: url)
    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
    
    if method == "GET" {
      let queryItems = params.map {
        URLQueryItem(name: $0.0, value: $0.1)
      }
      urlComponents.queryItems = queryItems
    }
    
    request.url = urlComponents.url
    request.httpMethod = method
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let session = URLSession.shared
    return session.rx.data(request: request)
  }
}
