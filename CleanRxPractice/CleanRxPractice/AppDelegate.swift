//
//  AppDelegate.swift
//  CleanRxPractice
//
//  Created by 김호준 on 2022/03/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    let provider = NetworkSearchFollowersUseCaseProvider()
    let viewModel = SearchFollowersViewModel(
      useCase: provider.makeSearchFollowersUseCase()
    )
    let viewController = SearchFollowersViewController()
    viewController.viewModel = viewModel
    window?.rootViewController = viewController
    
    return true
  }
}

