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
  
  func getItem(_ path: String) -> Observable<T> {
    let absolutePath = endPoint + "/\(path)"
    return RxAlamofire
      .data(.get, absolutePath)
      .debug()
      .observe(on: scheduler)
      .map({ data -> T in
        return try JSONDecoder().decode(T.self, from: data)
      })
  }
  
  func getItems(_ path: String) -> Observable<[T]> {
    let absolutePath = endPoint + "/\(path)"
    return RxAlamofire
      .data(.get, absolutePath)
      .debug()
      .observe(on: scheduler)
      .map({ data -> [T] in
        return try JSONDecoder().decode([T].self, from: data)
      })
  }
}
