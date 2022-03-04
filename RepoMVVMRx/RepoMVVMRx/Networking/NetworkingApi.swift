import Foundation
import RxSwift
import RxCocoa

final class NetworkingApi: NetworkingService {
  func searchRepos(with query: String) -> Observable<[Repo]> {
    let request = URLRequest(url: URL(string: "https://api.github.com/search/repositories?q=\(query)")!)
    return URLSession.shared.rx.data(request: request)
      .map({ data -> [Repo] in
        guard let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
          return []
        }
        return response.items
      })
  }
}
