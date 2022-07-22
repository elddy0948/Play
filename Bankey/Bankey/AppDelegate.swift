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
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    viewController.delegate = self
    onboardingContainerViewController.delegate = self
    window?.rootViewController = onboardingContainerViewController
    
    return true
  }
}

extension AppDelegate: LoginViewControllerDelegate {
  func didLogin(_ sender: LoginViewController) {
    print("foo - did login!")
  }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
  func didFinishOnboarding(_ sender: OnboardingContainerViewController) {
    print("foo - finish onboarding!")
  }
}
