import Foundation
import RxSwift

public protocol DownloadAvatarUseCase {
  func download(_ path: String) -> Observable<Data>
}
