//
//  ViewController.swift
//  Bankey
//
//  Created by 김호준 on 2022/07/05.
//

import UIKit

class LoginViewController: UIViewController {
  
  let loginView = LoginView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    style()
    layout()
  }
}

extension LoginViewController {
  private func style() {
    loginView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func layout() {
    view.addSubview(loginView)
    
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
  }
}

