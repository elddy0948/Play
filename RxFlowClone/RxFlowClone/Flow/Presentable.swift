import RxSwift
import UIKit.UIViewController

protocol Presentable {
  var rxVisible: Observable<Bool> { get }
  var rxDismissed: Single<Void> { get }
}

extension Presentable where Self: UIViewController {
  var rxVisible: Observable<Bool> {
    return self.rx.displayed
  }
  
  var rxDismissed: Single<Void> {
    return self.rx.dismissed.map({ _ -> Void in
      return Void()
    })
    .take(1)
    .asSingle()
  }
}

extension Presentable where Self: UIWindow {
  var rxVisible: Observable<Bool> {
    return self.rx.windowDidAppear.asObservable().map({ return true })
  }
  
  var rxDismissed: Single<Void> {
    return Single.never()
  }
}
