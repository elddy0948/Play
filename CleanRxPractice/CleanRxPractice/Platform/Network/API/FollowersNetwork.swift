import Foundation
import RxSwift

public final class FollowersNetwork {
  private let network: Network<Follower>
  
  init(network: Network<Follower>) {
    self.network = network
  }
  
  public func fetchFollowers(
    username: String
  ) -> Observable<[Follower]> {
    return network.getItems("\(username)/followers")
  }
}
