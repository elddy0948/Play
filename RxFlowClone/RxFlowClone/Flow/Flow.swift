import RxSwift
import UIKit
import RxRelay

private var subjectContext: UInt8 = 0

protocol Flow: AnyObject, Presentable, Synchronizable {
  var root: Presentable { get }
  // Adapts an incoming step before the navigate(to:) function
  func adapt(step: Step) -> Single<Step>
  func navigate(to step: Step) -> FlowContributors
}

extension Flow {
  func adapt(step: Step) -> Single<Step> {
    return .just(step)
  }
  
  var flowReadySubject: PublishRelay<Bool> {
    return self.synchronized {
      if let subject = objc_getAssociatedObject(self, &subjectContext) as? PublishRelay<Bool> {
        return subject
      }
      let newSubject = PublishRelay<Bool>()
      objc_setAssociatedObject(
        self, &subjectContext, newSubject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
      return newSubject
    }
  }
  
  var rxFlowReady: Single<Bool> {
    return self.flowReadySubject.take(1).asSingle()
  }
}
