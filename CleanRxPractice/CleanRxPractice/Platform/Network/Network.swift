import Foundation
import RxSwift

final class Network<T: Decodable> {
  private let endPoint: String
  private let scheduler: ConcurrentDispatchQueueScheduler
  
  init(_ endPoint: String) {
    self.endPoint = endPoint
    self.scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
  }
  
//  func getFollowers(_ username: String) -> Observable<T> {
//    let absolutePath = endPoint + "\(username)/followers"
//  }
}
