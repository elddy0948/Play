import Foundation

extension ObservableType {
  public func map<U>(_ transform: @escaping (E) throws -> U) -> Observable<U> {
    return Observable<U> { observer in
      return self.subscribe(observer: Observer(handler: { event in
        switch event {
        case .next(let element):
          do {
            try observer.on(event: .next(transform(element)))
          } catch {
            observer.on(event: .error(error))
          }
        case .error(let e):
          observer.on(event: .error(e))
        case .completed:
          observer.on(event: .completed)
        }
      }))
    }
  }
}
