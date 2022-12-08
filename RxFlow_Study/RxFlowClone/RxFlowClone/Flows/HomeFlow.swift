//
//  HomeFlow.swift
//  RxFlowClone
//
//  Created by 김호준 on 2022/07/13.
//

import Foundation
import UIKit

class HomeFlow: Flow {
  var root: Presentable {
    return self.rootViewController
  }
  
  private lazy var rootViewController: UINavigationController = {
    let viewController = UINavigationController()
    return viewController
  }()
  
  init() {}
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? DemoStep else { return .none }
    switch step {
    case .homeIsRequired:
      return self.navigateToHome()
    case .loginIsRequired:
      return .end(
        forwardToParentFlowWithStep: DemoStep.loginIsRequired
      )
    }
  }
  
  private func navigateToHome() -> FlowContributors {
    let viewController = HomeViewController()
    self.rootViewController.setViewControllers(
      [viewController], animated: false
    )
    return .one(flowContributor: .contribute(
      withNext: viewController)
    )
  }
}
