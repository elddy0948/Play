import Foundation
import RxSwift

public final class NetworkDownloadAvatarUseCaseProvider: DownloadAvatarUseCaseProvider {
  private let networkProvider: NetworkProvider
  
  public init() {
    self.networkProvider = NetworkProvider()
  }
  
  public func makeDownloadAvatarUseCase(_ path: String) -> DownloadAvatarUseCase {
    return NetworkDownloadAvatarUseCase(network: networkProvider.makeAvatarNetwork(path))
  }
}
