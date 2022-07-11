import UIKit.UIWindow
import RxSwift

extension Reactive where Base: UIWindow {
  var windowDidAppear: Observable<Void> {
    return self.sentMessage(#selector(
      Base.makeKeyAndVisible)
    )
    .map({ _ in return () })
  }
}
