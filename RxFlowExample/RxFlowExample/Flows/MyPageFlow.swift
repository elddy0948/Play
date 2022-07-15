import RxFlow
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
    return .one(flowContributor: .contribute(withNext: viewController))
  }
}
