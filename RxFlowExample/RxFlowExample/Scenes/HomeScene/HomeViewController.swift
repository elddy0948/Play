import UIKit
import RxRelay
import RxFlow

final class HomeViewController: UIViewController {
  
  private lazy var button: UIButton = {
    let button = UIButton()
    button.setTitle("Next Page", for: [])
    button.setTitleColor(UIColor.link, for: [])
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemGray
    
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
    
  }
}

class HomeStepper: Stepper {
  var steps = PublishRelay<Step>()
  
  var initialStep: Step {
    return ExampleStep.homeIsRequired
  }
}
