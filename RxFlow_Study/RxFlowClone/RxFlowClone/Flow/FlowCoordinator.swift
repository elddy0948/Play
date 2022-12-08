import Foundation
import RxCocoa
import RxSwift

final class FlowCoordinator: NSObject {
  private let disposeBag = DisposeBag()
  
  private var childFlowCoordinators = [String: FlowCoordinator]()
  
  private weak var parentFlowCoordinator: FlowCoordinator? {
    didSet {
      if let parentFlowCoordinator = self.parentFlowCoordinator {
        self.willNavigateRelay.bind(
          to: parentFlowCoordinator.willNavigateRelay
        )
        .disposed(by: self.disposeBag)
        self.didNavigateRelay.bind(
          to: parentFlowCoordinator.didNavigateRelay
        )
        .disposed(by: self.disposeBag)
      }
    }
  }
  
  private let stepsRelay = PublishRelay<Step>()
  let willNavigateRelay = PublishRelay<(Flow, Step)>()
  let didNavigateRelay = PublishRelay<(Flow, Step)>()
  
  let identifier = UUID().uuidString
  
  func coordinate(
    flow: Flow, with stepper: Stepper = DefaultStepper(),
    allowStepWhenDismissed: Bool = false
  ) {
    self.stepsRelay
      .observe(on: ConcurrentMainScheduler.instance)
      .do(
        onDispose: { [weak self] in
          self?.childFlowCoordinators.removeAll()
          self?.parentFlowCoordinator?.childFlowCoordinators.removeValue(
            forKey: self?.identifier ?? ""
          )
        }
      )
      .asSignal(onErrorJustReturn: NoneStep())
      .flatMap({ flow.adapt(step: $0).asSignal(onErrorJustReturn: NoneStep())})
      .do(onNext: { [weak self] in self?.willNavigateRelay.accept((flow, $0)) })
      .map({ return (flowContributors: flow.navigate(to: $0), step: $0)})
        .do(onNext: { [weak self] in self?.didNavigateRelay.accept((flow, $0.step)) })
        .map({ $0.flowContributors })
        .do(onNext: { [weak self] flowContributors in
          switch flowContributors {
          case let .one(flowContributor):
            self?.performSideEffects(with: flowContributor)
          case .end(let forwardToParentFlowWithStep):
            self?.parentFlowCoordinator?.stepsRelay.accept(forwardToParentFlowWithStep)
            self?.childFlowCoordinators.removeAll()
            self?.parentFlowCoordinator?.childFlowCoordinators.removeValue(forKey: self?.identifier ?? "")
          case let .multiple(childFlowContributors):
            childFlowContributors.forEach { self?.performSideEffects(with: $0) }
          case .none:
            break
          }
        })
        .map({ [weak self] in self?.nextPresentablesAndSteppers(from: $0) ?? [] })
        .do(onNext: { [weak self] presentableAndSteppers in
          self?.setReadiness(for: flow, basedOn: presentableAndSteppers.map({ $0.presentable }))
        })
        .flatMap({ Signal.from($0) })
        .do(onNext: { [weak self] presentableAndStepper in
          if let childFlow = presentableAndStepper.presentable as? Flow {
            let childFlowCoordinator = FlowCoordinator()
            childFlowCoordinator.parentFlowCoordinator = self
            self?.childFlowCoordinators[childFlowCoordinator.identifier] = childFlowCoordinator
            childFlowCoordinator.coordinate(flow: childFlow,
                                            with: presentableAndStepper.stepper,
                                            allowStepWhenDismissed: presentableAndStepper.allowStepWhenDismissed)
          }
        })
        .filter { !($0.presentable is Flow) }
        .flatMap { [weak self] in
          self?.steps(from: $0, within: flow, allowStepWhenDismissed: allowStepWhenDismissed) ?? Signal.empty()
        }
        .asObservable()
        .take(until: allowStepWhenDismissed ? .empty() : flow.rxDismissed.asObservable())
        .asSignal(onErrorJustReturn: NoneStep())
        .emit(to: self.stepsRelay)
        .disposed(by: self.disposeBag)
    
    stepper.steps
      .do(onSubscribed: { stepper.readyToEmitSteps() })
      .startWith(stepper.initialStep)
        .filter { !($0 is NoneStep) }
        .take(until: allowStepWhenDismissed ? .empty() : flow.rxDismissed.asObservable())
        .bind(to: self.stepsRelay)
        .disposed(by: self.disposeBag)
  }
  
  private func navigate(to step: Step) {
    self.stepsRelay.accept(step)
    self.childFlowCoordinators.values.forEach(
      { $0.navigate(to: step) }
    )
  }
  
  private func performSideEffects(with flowContributor: FlowContributor) {
    switch flowContributor {
    case .contribute:
      break
    case .forwardToCurrentFlow(let withStep):
      DispatchQueue.main.async { [weak self] in
        self?.stepsRelay.accept(withStep)
      }
    case .forwardToParentFlow(let withStep):
      parentFlowCoordinator?.stepsRelay.accept(withStep)
    }
  }
  
  private func nextPresentablesAndSteppers(from flowContributors: FlowContributors) -> [PresentableAndStepper] {
    switch flowContributors {
    case .none, .one(.forwardToCurrentFlow), .one(.forwardToParentFlow), .end:
      return []
    case let .one(.contribute(nextPresentable, nextStepper, allowStepWhenNotPresented, allowStepWhenDismissed)):
      return [PresentableAndStepper(presentable: nextPresentable,
                                    stepper: nextStepper,
                                    allowStepWhenNotPresented: allowStepWhenNotPresented,
                                    allowStepWhenDismissed: allowStepWhenDismissed)]
    case .multiple(let flowContributors):
      return flowContributors.compactMap { flowContributor -> PresentableAndStepper? in
        if case let .contribute(nextPresentable,
                                nextStepper,
                                allowStepWhenNotPresented,
                                allowStepWhenDismissed) = flowContributor {
          return PresentableAndStepper(presentable: nextPresentable,
                                       stepper: nextStepper,
                                       allowStepWhenNotPresented: allowStepWhenNotPresented,
                                       allowStepWhenDismissed: allowStepWhenDismissed)
        }
        
        return nil
      }
    }
  }
  
  private func steps (from nextPresentableAndStepper: PresentableAndStepper,
                      within flow: Flow,
                      allowStepWhenDismissed: Bool = false) -> Signal<Step> {
    var stepStream = nextPresentableAndStepper
      .stepper
      .steps
      .do(onSubscribed: { nextPresentableAndStepper.stepper.readyToEmitSteps() })
      .startWith(nextPresentableAndStepper.stepper.initialStep)
      .filter { !($0 is NoneStep) }
      .take(until: allowStepWhenDismissed ? .empty() : nextPresentableAndStepper.presentable.rxDismissed.asObservable())
    
    if nextPresentableAndStepper.allowStepWhenNotPresented == false {
      stepStream = stepStream.pausable(withPauser: nextPresentableAndStepper.presentable.rxVisible)
    }
    
    return stepStream.asSignal(onErrorJustReturn: NoneStep())
  }
  
  private func setReadiness (for flow: Flow, basedOn presentables: [Presentable]) {
    let flowReadySingles = presentables
      .filter { $0 is Flow }
      .map { $0 as! Flow }
      .map { $0.rxFlowReady }
    
    if flowReadySingles.isEmpty {
      flow.flowReadySubject.accept(true)
    } else {
      _ = Single<Bool>.zip(flowReadySingles)
        .map { _ in return true }
        .asObservable()
        .take(1)
        .bind(to: flow.flowReadySubject)
    }
  }
}

extension Reactive where Base: FlowCoordinator {
  var willNavigate: Observable<(Flow, Step)> {
    return self.base.willNavigateRelay.asObservable()
  }
  
  var didNavigate: Observable<(Flow, Step)> {
    return self.base.didNavigateRelay.asObservable()
  }
}

private class PresentableAndStepper {
  let presentable: Presentable
  let stepper: Stepper
  let allowStepWhenNotPresented: Bool
  let allowStepWhenDismissed: Bool
  
  init(presentable: Presentable, stepper: Stepper,
       allowStepWhenNotPresented: Bool, allowStepWhenDismissed: Bool) {
    self.presentable = presentable
    self.stepper = stepper
    self.allowStepWhenNotPresented = allowStepWhenNotPresented
    self.allowStepWhenDismissed = allowStepWhenDismissed
  }
}
