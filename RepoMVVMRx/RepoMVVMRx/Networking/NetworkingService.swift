import Foundation
import RxSwift

protocol NetworkingService {
  func searchRepos(with query: String) -> Observable<[Repo]>
}
