import RxCocoa
import RxSwift

protocol Stepper {
  var steps: PublishRelay<Step> { get }
  var initialStep: Step { get }
  func readyToEmitSteps()
}

extension Stepper {
  var initialStep: Step {
    return NoneStep()
  }
  
  func readyToEmitSteps() {}
}

public class OneStepper: Stepper {
  let steps = PublishRelay<Step>()
  private let singleStep: Step
  
  init(withSingleStep singleStep: Step) {
    self.singleStep = singleStep
  }
  
  var initialStep: Step {
    return self.singleStep
  }
}

class DefaultStepper: OneStepper {
  init() {
    super.init(withSingleStep: RxFlowStep.home)
  }
}

class CompositeStepper: Stepper {
  private let disposeBag = DisposeBag()
  private let innerSteppers: [Stepper]
  public let steps = PublishRelay<Step>()
  
  init(steppers: [Stepper]) {
    self.innerSteppers = steppers
  }
  
  func readyToEmitSteps() {
    let initialSteps = Observable<Step>.from(
      self.innerSteppers.map({ $0.initialStep })
    )
    let nextSteps = Observable<Step>
      .merge(self.innerSteppers.map({ $0.steps.asObservable() }))
    initialSteps
      .concat(nextSteps)
      .bind(to: self.steps)
      .disposed(by: self.disposeBag)
    
    self.innerSteppers.forEach({ stepper in
      stepper.readyToEmitSteps()
    })
  }
}

final class NoneStepper: OneStepper {
  convenience init() {
    self.init(withSingleStep: NoneStep())
  }
}
