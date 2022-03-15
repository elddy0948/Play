import Foundation
import RxSwift
import RxAlamofire

final class Network<T: Decodable> {
  private let endPoint: String
  private let scheduler: ConcurrentDispatchQueueScheduler
  
  init(_ endPoint: String) {
    self.endPoint = endPoint
    self.scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
  }
  
  func getFollowers(_ username: String) -> Observable<[T]> {
    let absolutePath = endPoint + "/\(username)/followers"
    return RxAlamofire
      .data(.get, absolutePath)
      .debug()
      .observe(on: scheduler)
      .map({ data -> [T] in
        do {
          let followers = try JSONDecoder().decode([T].self,
                                                   from: data)
          return followers
        } catch {
          print("Decode error")
          return []
        }
      })
  }
}
