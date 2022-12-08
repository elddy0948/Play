import ObjectiveC

protocol Synchronizable {}

extension Synchronizable {
  func synchronized<T>(_ action: () -> T) -> T {
    objc_sync_enter(self)
    let result = action()
    objc_sync_exit(self)
    return result
  }
}
