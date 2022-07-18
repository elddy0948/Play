import UIKit
import RxFlow
import RxRelay

final class MyPageViewController: UIViewController {
  private lazy var button: UIButton = {
    let button = UIButton()
    button.setTitle("Next Page", for: [])
    button.setTitleColor(UIColor.link, for: [])
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemGreen
    
    view.addSubview(button)
    
    button.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.centerXAnchor
      ),
      button.centerYAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.centerYAnchor
      )
    ])
  }
}

class MyPageStepper: Stepper {
  var steps = PublishRelay<Step>()
  
  var initialStep: Step {
    return ExampleStep.mypageIsRequired
  }
}
