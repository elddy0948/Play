import Foundation
import RxSwift

public final class NetworkDownloadAvatarUseCase: DownloadAvatarUseCase {
  private let network: AvatarNetwork
  
  init(network: AvatarNetwork) {
    self.network = network
  }
  
  public func download(_ path: String) -> Observable<Data> {
    return network.downloadAvatar(path)
  }
}
