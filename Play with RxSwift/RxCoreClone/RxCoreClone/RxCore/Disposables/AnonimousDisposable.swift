import Foundation

// dispose시 호출 될 closure를 제공.
public final class AnonimousDisposable: Disposable {
  private let _disposeHandler: () -> Void
  
  public init(_ disposeClosure: @escaping () -> Void) {
    _disposeHandler = disposeClosure
  }
  
  public func dispose() {
    _disposeHandler()
  }
}
