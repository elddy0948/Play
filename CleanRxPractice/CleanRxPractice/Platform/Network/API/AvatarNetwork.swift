import Foundation
import RxSwift

final class AvatarNetwork {
  private let network: Network<Data>
  
  init(_ network: Network<Data>) {
    self.network = network
  }
  
  public func downloadAvatar(_ path: String) -> Observable<Data> {
    return network.downloadItem(path)
  }
}
