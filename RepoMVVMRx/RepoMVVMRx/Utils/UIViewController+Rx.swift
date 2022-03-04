import RxSwift
import UIKit
import RxCocoa

extension Reactive where Base: UIViewController {
  var viewWillAppear: ControlEvent<Void> {
    let source = self.methodInvoked(#selector(Base.viewWillAppear(_:)))
      .map({_ in })
    //To make Observable<Void>
    return ControlEvent(events: source)
  }
}
