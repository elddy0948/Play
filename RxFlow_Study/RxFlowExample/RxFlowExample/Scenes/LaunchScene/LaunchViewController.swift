import UIKit
import RxFlow
import RxRelay

final class LaunchViewController: UIViewController, Stepper {
  var steps = PublishRelay<Step>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBlue
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [unowned self] in
      self.steps.accept(ExampleStep.mainIsRequired)
    })
  }
}
