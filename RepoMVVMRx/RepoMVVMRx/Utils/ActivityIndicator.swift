import RxSwift
import RxCocoa

private struct ActivityToken<Element>: ObservableConvertibleType, Disposable {
  private let _source: Observable<Element>
  private let _dispose: Cancelable
  
  init(source: Observable<Element>, disposeAction: @escaping () -> ()) {
    _source = source
    _dispose = Disposables.create(with: disposeAction)
  }
  
  func dispose() {
    _dispose.dispose()
  }
  
  func asObservable() -> Observable<Element> {
    return _source
  }
}

public class ActivityIndicator : SharedSequenceConvertibleType {
  public typealias Element = Bool
  public typealias SharingStrategy = DriverSharingStrategy
  
  private let _lock = NSRecursiveLock()
  private let _relay = BehaviorRelay(value: 0)
  private let _loading: SharedSequence<SharingStrategy, Bool>
  
  public init() {
    _loading = _relay.asDriver()
      .map { $0 > 0 }
      .distinctUntilChanged()
  }
  
  fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.Element> {
    return Observable.using({ () -> ActivityToken<O.Element> in
      self.increment()
      return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
    }) { t in
      return t.asObservable()
    }
  }
  
  private func increment() {
    _lock.lock()
    _relay.accept(_relay.value + 1)
    _lock.unlock()
  }
  
  private func decrement() {
    _lock.lock()
    _relay.accept(_relay.value - 1)
    _lock.unlock()
  }
  
  public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
    return _loading
  }
}

extension ObservableConvertibleType {
  public func trackActivity(_ activityIndicator: ActivityIndicator) -> Observable<Element> {
    return activityIndicator.trackActivityOfObservable(self)
  }
}
