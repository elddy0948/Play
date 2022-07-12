import UIKit

class LoginFlow: Flow {
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
    case .loginIsRequired:
      return self.navigateToLogin()
    case .homeIsRequired:
      return .end(
        forwardToParentFlowWithStep: DemoStep.homeIsRequired
      )
    }
  }
  
  private func navigateToLogin() -> FlowContributors {
    let viewController = LoginViewController()
    self.rootViewController.setViewControllers(
      [viewController], animated: false
    )
    return .one(
      flowContributor: .contribute(withNext: viewController)
    )
  }
}
