import UIKit
import RxFlow
import RxRelay

final class MyPageViewController: UIViewController {
  var steps = PublishRelay<Step>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemGreen
  }
}

extension MyPageViewController: Stepper {}

class MyPageStepper: Stepper {
  var steps = PublishRelay<Step>()
  
  var initialStep: Step {
    return ExampleStep.mypageIsRequired
  }
}
