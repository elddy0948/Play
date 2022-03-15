import Foundation
import RxSwift

public final class NetworkSearchFollowersUseCase: SearchFollowersUseCase {
  private let network: FollowersNetwork
  
  init(network: FollowersNetwork) {
    self.network = network
  }
  
  public func search(username: String) -> Observable<[Follower]> {
    let stored = network.fetchFollowers()
    return stored
  }
}
