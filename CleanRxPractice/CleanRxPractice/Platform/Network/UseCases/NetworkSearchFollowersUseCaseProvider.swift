import Foundation

public final class NetworkSearchFollowersUseCaseProvider: SearchFollowersUseCaseProvider {
  private let networkProvider: NetworkProvider
  
  public init() {
    networkProvider = NetworkProvider()
  }
  
  public func makeSearchFollowersUseCase() -> SearchFollowersUseCase {
    return NetworkSearchFollowersUseCase(network: networkProvider.makeFollowersNetwork())
  }
}
