import UIKit
import RxRelay
import RxCocoa

class LoginViewController: UIViewController, Stepper {
  var steps = PublishRelay<Step>()
  
  var button: UIButton = {
    let button = UIButton()
    button.setTitle("로그인", for: .normal)
    button.backgroundColor = .systemBlue
    button.addTarget(
      self,
      action: #selector(loginButtonDidTap), for: .touchUpInside
    )
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Login"
    self.view.backgroundColor = .systemBackground
    self.view.addSubview(self.button)
    
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
  
  @objc func loginButtonDidTap() {
    self.steps.accept(DemoStep.homeIsRequired)
  }
}
