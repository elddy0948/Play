import UIKit

protocol FirstViewControllerDelegate: AnyObject {
  func didTappedButton(_ viewController: UIViewController)
}

class FirstViewController: UIViewController {
  
  private lazy var button: UIButton = {
    let button = UIButton()
    button.setTitle("Go Next!", for: .normal)
    button.setTitleColor(.label, for: .normal)
    return button
  }()
  
  //MARK: - Properties
  weak var delegate: FirstViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemRed
    
    setupButton()
    layout()
  }
  
  @objc func didTappedButton(_ sender: UIButton) {
    delegate?.didTappedButton(self)
  }
}

//MARK: - UI Setup / Layout
extension FirstViewController {
  private func setupButton() {
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.addTarget(self,
                     action: #selector(didTappedButton(_:)),
                     for: .touchUpInside)
  }
  
  private func layout() {
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
