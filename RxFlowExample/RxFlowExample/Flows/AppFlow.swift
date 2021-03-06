import RxFlow
import UIKit

final class AppFlow: Flow {
  private let window: UIWindow
  
  var root: Presentable {
    return self.window
  }
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? ExampleStep else { return .none }
    switch step {
    case .launchIsRequired:
      return navigateToLaunchScreen()
    case .mainIsRequired:
      return navigateToMainTabBar()
    default:
      return .none
    }
  }
  
  private func navigateToLaunchScreen() -> FlowContributors {
    let viewController = LaunchViewController()
    window.rootViewController = viewController
    return .one(flowContributor: .contribute(withNext: viewController))
  }
  
  private func navigateToMainTabBar() -> FlowContributors {
    let flow = MainFlow()
    let stepper = MainStepper()
    
    Flows.use(flow, when: .created, block: { [unowned self] root in
      self.window.rootViewController = root
    })
    
    return .one(flowContributor: .contribute(
      withNextPresentable: flow,
      withNextStepper: stepper
    ))
  }
}
