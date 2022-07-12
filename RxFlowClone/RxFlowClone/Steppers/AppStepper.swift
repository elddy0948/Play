import Foundation
import RxSwift
import RxRelay

class AppStepper: Stepper {
  let steps = PublishRelay<Step>()
  
  private let disposeBag = DisposeBag()
  
  init() {}
  
  var initialStep: Step {
    return DemoStep.splash
  }
}
