import RxFlow
import UIKit

final class HomeFlow: Flow {
  var root: Presentable {
    return self.tabBarController
  }
  
  private let tabBarController = UITabBarController()
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? ExampleStep else { return .none }
    switch step {
    case .homeIsRequired:
      return navigateToHome()
    default:
      return .none
    }
  }
  
  private func navigateToHome() -> FlowContributors {
    let viewController = HomeViewController()
    tabBarController.setViewControllers([viewController], animated: false)
    return .none
  }
}
