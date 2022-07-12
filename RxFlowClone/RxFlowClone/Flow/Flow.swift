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

enum Flows {
  enum ExecuteStrategy {
    case ready
    case created
  }
  
  static func use<Root: UIViewController>(
    _ flows: [Flow],
    when strategy: ExecuteStrategy,
    block: @escaping ([Root]) -> Void
  ) {
    let roots = flows.compactMap({ $0.root as? Root })
    guard roots.count == flows.count else {
      fatalError("Type mismatch, Flows roots types do not match the types awaited in the block")
    }
    
    switch strategy {
    case .ready:
      let flowsReadinesses = flows.map({ $0.rxFlowReady })
      _ = Single.zip(flowsReadinesses) { _ in return Void() }
        .asDriver(onErrorJustReturn: Void())
        .drive(onNext: { _ in
          block(roots)
        })
    case .created:
      block(roots)
    }
  }
  
  static func use<Root>(
    _ flow: Flow,
    when strategy: ExecuteStrategy,
    block: @escaping (_ flowRoot: Root) -> Void
  ) where Root: UIViewController {
    guard let root = flow.root as? Root else {
      fatalError()
    }
    
    switch strategy {
    case .ready:
      _ = flow
        .rxFlowReady
        .asDriver(onErrorJustReturn: true)
        .drive(onNext: { _ in
          block(root)
        })
    case .created:
      block(root)
    }
  }
}
