import UIKit
import RxCocoa

class HomeViewController: UIViewController, Stepper {
  var steps = PublishRelay<Step>()
  
  var button: UIButton = {
    let button = UIButton()
    button.setTitle("로그아웃", for: .normal)
    button.backgroundColor = .systemRed
    button.addTarget(
      self,
      action: #selector(logoutButtonDidTap),
      for: .touchUpInside
    )
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Home"
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
  
  @objc func logoutButtonDidTap() {
    self.steps.accept(DemoStep.loginIsRequired)
  }
}
