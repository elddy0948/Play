import Combine
import UIKit

class ViewController: UIViewController {
  //MARK: - Views
  private let nameTextField = UCTextField(placeholder: "Enter name...", imageName: "person.circle")
  private let passwordTextField = UCTextField(placeholder: "Enter password...", imageName: "lock.circle")
  private let repeatPasswordTextField = UCTextField(placeholder: "Repeat password", imageName: "lock.circle")
  private let createAccountButton = UIButton(type: .system)
  
  @Published var username: String = ""
  @Published var password: String = ""
  @Published var repeatPassword: String = ""
  
  var validatedUsername: AnyPublisher<String?, Never> {
    return $username
      .debounce(for: 0.5, scheduler: RunLoop.main)
      .removeDuplicates()
      .flatMap({ username in
        return Future({ promise in
          self.usernameAvailable(username, completion: { available in
            promise(.success(available ? username : nil))
          })
        })
      })
      .eraseToAnyPublisher()
  }
  
  var validatedPassword: AnyPublisher<String?, Never> {
    return Publishers.CombineLatest($password, $repeatPassword)
      .map({ (password, repeatPassword) -> String? in
        guard password == repeatPassword,
              password.count > 0 else { return nil }
        return password
      })
      .map({ ($0 ?? "") == "password" ? nil : $0 })
      .eraseToAnyPublisher()
  }
  
  var validatedCredentials: AnyPublisher<(String, String)?, Never> {
    return Publishers.CombineLatest(validatedUsername, validatedPassword)
      .receive(on: RunLoop.main)
      .map({ (username, password) -> (String, String)? in
        guard let name = username, let pwd = password else { return nil }
        return (name, pwd)
      })
      .eraseToAnyPublisher()
  }
  
  var createButtonSubscriber: AnyCancellable?

  override func viewDidLoad() {
    super.viewDidLoad()

    style()
    layout()
    setup()
  }
  
  func setup() {
    createButtonSubscriber = validatedCredentials
      .map({ $0 != nil })
      .receive(on: RunLoop.main)
      .assign(to: \.isEnabled, on: createAccountButton)
  }
  
  @objc private func createButtonTapped() {
    print("Create Button Tapped")
  }
  
  private func usernameAvailable(_ username: String, completion: (Bool) -> Void) {
    completion(true)
  }
}

extension ViewController {
  private func style() {
    view.backgroundColor = .systemBackground
    
    passwordTextField.isSecureTextEntry = true
    repeatPasswordTextField.isSecureTextEntry = true
    
    nameTextField.delegate = self
    passwordTextField.delegate = self
    repeatPasswordTextField.delegate = self
    
    createAccountButton.setTitle("Create Account", for: .normal)
    createAccountButton.setTitleColor(.white, for: .normal)
    createAccountButton.backgroundColor = .link
    createAccountButton.layer.cornerRadius = 8
    createAccountButton.layer.masksToBounds = true
    createAccountButton.isEnabled = false
    
    createAccountButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
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

extension ViewController: UITextFieldDelegate {
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    let textFieldText = textField.text ?? ""
    let text = (textFieldText as NSString).replacingCharacters(in: range, with: string)
    
    if textField == nameTextField {
      username = text
    } else if textField == passwordTextField {
      password = text
    } else if textField == repeatPasswordTextField {
      repeatPassword = text
    }
    
    return true
  }
}
