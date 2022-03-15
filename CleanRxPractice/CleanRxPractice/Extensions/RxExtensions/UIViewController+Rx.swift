import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
  var viewDidLoad: ControlEvent<Void> {
    let source = self.methodInvoked(#selector(base.viewDidLoad)).map({ _ in })
    return ControlEvent(events: source)
  }
  
  var viewWillAppear: ControlEvent<Bool> {
    let source = self.methodInvoked(
      #selector(base.viewWillAppear(_:))
    ).map({ $0.first as? Bool ?? false })
    return ControlEvent(events: source)
  }
}
