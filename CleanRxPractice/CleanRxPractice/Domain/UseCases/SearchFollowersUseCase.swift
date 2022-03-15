import Foundation
import RxSwift

public protocol SearchFollowersUseCase {
  func search(username: String) -> Observable<[Follower]>
}
