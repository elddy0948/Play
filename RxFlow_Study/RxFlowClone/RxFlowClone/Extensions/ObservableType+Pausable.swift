import Foundation
import RxSwift

extension ObservableType {
  
  func pausable<P: ObservableType>(withPauser pauser: P) -> Observable<Element> where P.Element == Bool {
    return withLatestFrom(pauser) { element, paused in return (element, paused) }
      .filter({ _, paused in return paused})
      .map({ element, _ in return element})
  }
  
  func pausable<P>(afterCount count: Int, withPauser pauser: P) -> Observable<Element> where P: ObservableType, P.Element == Bool {
    return Observable<Element>.create({ observer in
      let lock = NSRecursiveLock()
      var paused = true
      var elementIndex = 0
      
      let pauserDisposable = pauser.subscribe({ [weak lock] event in
        lock?.lock()
        defer { lock?.unlock() }
        switch event {
        case .next(let resume):
          paused = !resume
        case .completed:
          observer.onCompleted()
        case .error(let error):
          observer.onError(error)
        }
      })
      
      let disposable = self.subscribe({ [weak lock] event in
        lock?.lock()
        defer { lock?.unlock() }
        
        switch event {
        case .next(let element):
          if (elementIndex < count) || !paused {
            elementIndex += 1
            observer.onNext(element)
          }
        case .completed:
          observer.onCompleted()
        case .error(let error):
          observer.onError(error)
        }
      })
      
      return Disposables.create([disposable, pauserDisposable])
    })
  }
}
