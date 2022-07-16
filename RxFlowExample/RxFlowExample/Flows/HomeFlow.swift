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
    return .none
  }
}

class HomeFlowStepper: Stepper {
  var steps = PublishRelay<Step>()
  
  var initialStep: Step {
    return ExampleStep.homeIsRequired
  }
}
