//
//  ViewController.swift
//  Bankey
//
//  Created by 김호준 on 2022/07/05.
//

import UIKit

class LoginViewController: UIViewController {
  
  let loginView = LoginView()
  let signInButton = UIButton(type: .system)
  let errorMessageLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
  
  @objc func signInTapped() {
    
  }
}

extension LoginViewController {
  private func style() {
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

