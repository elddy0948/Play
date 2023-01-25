import UIKit

class ViewController: UIViewController {
  
  private let nameTextField = UCTextField(placeholder: "Enter name...", imageName: "person.circle")
  private let passwordTextField = UCTextField(placeholder: "Enter password...", imageName: "lock.circle")
  private let repeatPasswordTextField = UCTextField(placeholder: "Repeat password", imageName: "lock.circle")
  private let createAccountButton = UIButton(type: .system)

  override func viewDidLoad() {
    super.viewDidLoad()

    style()
    layout()
  }
}

extension ViewController {
  private func style() {
    view.backgroundColor = .systemBackground
    createAccountButton.setTitle("Create Account", for: .normal)
    createAccountButton.setTitleColor(.white, for: .normal)
    createAccountButton.backgroundColor = .link
    createAccountButton.layer.cornerRadius = 8
    createAccountButton.layer.masksToBounds = true
  }
  
  private func layout() {
    view.addSubview(nameTextField)
    view.addSubview(passwordTextField)
    view.addSubview(repeatPasswordTextField)
    view.addSubview(createAccountButton)
    
    nameTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
    createAccountButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      nameTextField.topAnchor.constraint(
        equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
        multiplier: 2),
      nameTextField.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
        multiplier: 1),
      view.safeAreaLayoutGuide.trailingAnchor.constraint(
        equalToSystemSpacingAfter: nameTextField.trailingAnchor,
        multiplier: 1),
      nameTextField.heightAnchor.constraint(equalToConstant: 48),
      passwordTextField.topAnchor.constraint(
        equalToSystemSpacingBelow: nameTextField.bottomAnchor,
        multiplier: 1),
      passwordTextField.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
        multiplier: 1),
      view.safeAreaLayoutGuide.trailingAnchor.constraint(
        equalToSystemSpacingAfter: passwordTextField.trailingAnchor,
        multiplier: 1),
      passwordTextField.heightAnchor.constraint(equalToConstant: 48),
      repeatPasswordTextField.topAnchor.constraint(
        equalToSystemSpacingBelow: passwordTextField.bottomAnchor,
        multiplier: 1),
      repeatPasswordTextField.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
        multiplier: 1),
      view.safeAreaLayoutGuide.trailingAnchor.constraint(
        equalToSystemSpacingAfter: repeatPasswordTextField.trailingAnchor,
        multiplier: 1),
      repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 48),
      createAccountButton.topAnchor.constraint(
        equalToSystemSpacingBelow: repeatPasswordTextField.bottomAnchor,
        multiplier: 2),
      createAccountButton.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
        multiplier: 1),
      view.safeAreaLayoutGuide.trailingAnchor.constraint(
        equalToSystemSpacingAfter: createAccountButton.trailingAnchor,
        multiplier: 1),
      createAccountButton.heightAnchor.constraint(equalToConstant: 40),
    ])
  }
}

