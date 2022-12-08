import UIKit
import RxFlow
import RxRelay

final class MyPageViewController: UIViewController, Stepper {
  var steps = PublishRelay<Step>()
  
  private lazy var button: UIButton = {
    let button = UIButton()
    button.setTitle("Present ViewController", for: [])
    button.setTitleColor(UIColor.link, for: [])
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemGreen
    
    view.addSubview(button)
    
    button.addTarget(self,
                     action: #selector(didTappedButton),
                     for: .touchUpInside
    )
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
  
  @objc func didTappedButton() {
    self.steps.accept(ExampleStep.mypageNext)
  }
}

class MyPageStepper: Stepper {
  var steps = PublishRelay<Step>()
  
  var initialStep: Step {
    return ExampleStep.mypageIsRequired
  }
}
