import Foundation

final class NetworkProvider {
  private let endPoint: String
  
  public init() {
    endPoint = "https://api.github.com/users"
  }
  
  public func makeFollowersNetwork() -> FollowersNetwork {
    let network = Network<Follower>(endPoint)
    return FollowersNetwork(network: network)
  }
  
  public func makeAvatarNetwork(_ path: String) -> AvatarNetwork {
    let network = Network<Data>(path)
    return AvatarNetwork(network)
  }
}
