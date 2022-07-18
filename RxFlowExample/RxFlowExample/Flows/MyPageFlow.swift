import RxFlow
import RxRelay
import UIKit

final class MyPageFlow: Flow {
  var root: Presentable {
    return self.navigationController
  }
  
  private let navigationController = UINavigationController()
  
  func navigate(to step: Step) -> FlowContributors {
    guard let step = step as? ExampleStep else { return .none }
    switch step {
    case .mypageIsRequired:
      return navigateToMyPage()
    default:
      return .none
    }
  }
  
  private func navigateToMyPage() -> FlowContributors {
    let viewController = MyPageViewController()
    viewController.title = "My Page"
    navigationController.pushViewController(
      viewController, animated: false
    )
    return .none
  }
}
