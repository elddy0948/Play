import RxFlow
import RxRelay
import UIKit

final class MainFlow: Flow {
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
    let homeFlow = HomeFlow()
    let mypageFlow = MyPageFlow()
    
    let homeStepper = HomeFlowStepper()
    let mypageStepper = MyPageStepper()
    
    Flows.use(
      homeFlow, mypageFlow,
      when: .created,
      block: { [unowned self] (root1: UINavigationController, root2: UINavigationController) in
        let homeTabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
        let mypageTabBarItem = UITabBarItem(title: "MyPage", image: nil, tag: 1)
        
        root1.tabBarItem = homeTabBarItem
        root1.title = "Home"
        
        root2.tabBarItem = mypageTabBarItem
        root2.title = "MyPage"
        
        self.tabBarController.setViewControllers([root1, root2], animated: false)
      })
    return .multiple(flowContributors: [
      .contribute(
        withNextPresentable: homeFlow,
        withNextStepper: homeStepper
      ),
      .contribute(
        withNextPresentable: mypageFlow,
        withNextStepper: mypageStepper
      )
    ])
  }
}

class MainStepper: Stepper {
  var steps = PublishRelay<Step>()
  
  var initialStep: Step {
    return ExampleStep.homeIsRequired
  }
}
  
