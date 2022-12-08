import RxFlow
import RxRelay
import UIKit

final class HomeFlow: Flow {
  var root: Presentable {
    return self.navigationController
  }
  
  private let navigationController = UINavigationController()
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? ExampleStep else { return .none }
    
    switch step {
    case .homeIsRequired:
      return navigateToHome()
    case .homeNext:
      return navigateToNext()
    default:
      return .none
    }
  }
  
  private func navigateToHome() -> FlowContributors {
    let viewController = HomeViewController()
    viewController.title = "Home"
    navigationController.pushViewController(
      viewController, animated: false
    )
    return .one(flowContributor: .contribute(withNext: viewController))
  }
  
  private func navigateToNext() -> FlowContributors {
    let viewController = HomeNextViewController()
    viewController.title = "Home_Next"
    navigationController.pushViewController(
      viewController, animated: true
    )
    return .none
  }
}
