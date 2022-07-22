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
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
//    window?.rootViewController = OnboardingContainerViewController()
    window?.rootViewController = OnboardingViewController(
      imageName: "BlueBall",
      titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s."
    )
    
    return true
  }

}

