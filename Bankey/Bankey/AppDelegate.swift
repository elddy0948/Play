//
//  AppDelegate.swift
//  Bankey
//
//  Created by 김호준 on 2022/07/05.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  let viewController = LoginViewController()
  let onboardingContainerViewController = OnboardingContainerViewController()
  let dummyViewController = DummyViewController()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    
    viewController.delegate = self
    onboardingContainerViewController.delegate = self
    dummyViewController.logoutDelegate = self
    
    window?.rootViewController = viewController
    
    return true
  }
}

extension AppDelegate {
  private func setRootViewController(_ viewController: UIViewController, animated: Bool = true) {
    guard animated,
          let window = self.window else {
      self.window?.rootViewController = viewController
      self.window?.makeKeyAndVisible()
      return
    }
    window.rootViewController = viewController
    window.makeKeyAndVisible()
    UIView.transition(
      with: window,
      duration: 0.3,
      options: .transitionCrossDissolve,
      animations: nil,
      completion: nil
    )
  }
}

extension AppDelegate: LoginViewControllerDelegate {
  func didLogin(_ sender: LoginViewController) {
    setRootViewController(onboardingContainerViewController)
  }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
  func didFinishOnboarding(_ sender: OnboardingContainerViewController) {
    setRootViewController(dummyViewController)
  }
}

extension AppDelegate: LogoutDelegate {
  func didLogout() {
    setRootViewController(viewController)
  }
}


