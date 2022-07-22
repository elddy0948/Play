import UIKit

protocol LoginViewControllerDelegate: AnyObject {
  func didLogin(_ sender: LoginViewController)
}

class LoginViewController: UIViewController {
  
  weak var delegate: LoginViewControllerDelegate?
  
  let appTitleView = AppTitleView()
  let loginView = LoginView()
  let signInButton = UIButton(type: .system)
  let errorMessageLabel = UILabel()
  
  var username: String? {
    return loginView.usernameTextField.text
  }
  
  var password: String? {
    return loginView.passwordTextField.text
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

extension LoginViewController {
  private func style() {
    appTitleView.translatesAutoresizingMaskIntoConstraints = false
    loginView.translatesAutoresizingMaskIntoConstraints = false
    
    signInButton.translatesAutoresizingMaskIntoConstraints = false
    signInButton.setTitle("Sign In", for: [])
    signInButton.backgroundColor = .link
    signInButton.setTitleColor(.white, for: [])
    signInButton.layer.cornerRadius = 5
    signInButton.clipsToBounds = true
    signInButton.addTarget(
      self, action: #selector(signInTapped), for: .primaryActionTriggered
    )
    
    errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
    errorMessageLabel.textAlignment = .center
    errorMessageLabel.textColor = .systemRed
    errorMessageLabel.numberOfLines = 0
    errorMessageLabel.isHidden = true
  }
  
  private func layout() {
    view.addSubview(appTitleView)
    view.addSubview(loginView)
    view.addSubview(signInButton)
    view.addSubview(errorMessageLabel)
    
    NSLayoutConstraint.activate([
      loginView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      loginView.leadingAnchor.constraint(
        equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor,
        multiplier: 1
      ),
      view.safeAreaLayoutGuide.trailingAnchor.constraint(
        equalToSystemSpacingAfter: loginView.trailingAnchor,
        multiplier: 1
      ),
      loginView.topAnchor.constraint(
        equalToSystemSpacingBelow: appTitleView.bottomAnchor, multiplier: 1
      ),
      appTitleView.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
      appTitleView.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
    ])
    
    //Button
    NSLayoutConstraint.activate([
      signInButton.topAnchor.constraint(
        equalToSystemSpacingBelow: loginView.bottomAnchor,
        multiplier: 2
      ),
      signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
      signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
    ])
    
    //Error Label
    NSLayoutConstraint.activate([
      errorMessageLabel.topAnchor.constraint(
        equalToSystemSpacingBelow: signInButton.bottomAnchor,
        multiplier: 2
      ),
      errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
      errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
    ])
  }
}

extension LoginViewController {
  @objc func signInTapped(_ sender: UIButton) {
    errorMessageLabel.isHidden = true
    login()
  }
  
  private func login() {
    guard let username = username,
          let password = password else {
      assertionFailure("Username / password should never be nil")
      return
    }
    
    if username.isEmpty || password.isEmpty {
      configureView(withMessage: "Username / password cannot be blank")
      return
    }
    
    if username == "Joons" && password == "Welcome" {
      delegate?.didLogin(self)
    } else {
      configureView(withMessage: "Incorrect username / password")
    }
  }
  
  private func configureView(withMessage message: String) {
    errorMessageLabel.isHidden = false
    errorMessageLabel.text = message
  }
}
