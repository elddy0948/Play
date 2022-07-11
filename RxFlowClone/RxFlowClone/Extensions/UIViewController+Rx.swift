import UIKit.UIViewController
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
  var dismissed: ControlEvent<Bool> {
    let dismissedSource = self.sentMessage(
      #selector(Base.viewDidDisappear(_:)))
      .filter({ [base] _ in
        base.isBeingDismissed })
      .map({ _ in
        return false })
    
    let movedToParentSource = self.sentMessage(
      #selector(Base.didMove(toParent:))
    )
      .filter({ !($0.first is UIViewController) })
      .map({ _ in return false })
    
    return ControlEvent(
      events: Observable.merge(dismissedSource, movedToParentSource)
    )
  }
  
  var displayed: Observable<Bool> {
    let viewDidAppearObservable = self.sentMessage(
      #selector(Base.viewDidAppear(_:))
    )
      .map({ _ in return true })
    
    let viewDidDisappearObservable = self.sentMessage(
      #selector(Base.viewDidDisappear(_:))
    )
      .map({ _ in return false })
    
    let initialState = Observable.just(false)
    
    return initialState.concat(Observable<Bool>.merge(
      viewDidAppearObservable,
      viewDidDisappearObservable
    ))
  }
}
