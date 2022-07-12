import UIKit
import RxCocoa

class LoadingViewController: UIViewController, Stepper {
  var steps = PublishRelay<Step>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.steps.accept(DemoStep.splash)
  }
}
