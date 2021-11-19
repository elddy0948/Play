//
//  TabBarController.swift
//  Travlers
//
//  Created by 김호준 on 2021/11/19.
//

import UIKit

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewControllers = [configureHomeNavigationController(),
                       configureCityListNavigationController()]
//    tabBar.backgroundColor = .systemRed
  }
  
  
  private func configureHomeNavigationController() -> UINavigationController {
    let viewController = HomeViewController()
    let navigationController = UINavigationController(rootViewController: viewController)
    
    navigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
    
    return navigationController
  }
  
  private func configureCityListNavigationController() -> UINavigationController {
    let viewController = CityListViewController()
    let navigationController = UINavigationController(rootViewController: viewController)
    
    navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
    
    return navigationController
  }
}
