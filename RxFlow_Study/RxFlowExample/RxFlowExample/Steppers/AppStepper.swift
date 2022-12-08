import RxFlow
import RxRelay

final class AppStepper: Stepper {
  var steps = PublishRelay<Step>()
  
  init() {}
  
  var initialStep: Step {
    return ExampleStep.launchIsRequired
  }
}
