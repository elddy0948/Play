import UIKit

class NavigationRouter: NSObject {
  private var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    super.init()
  }
}

extension NavigationRouter: Router {
  func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    navigationController.pushViewController(
      viewController,
      animated: animated
    )
  }
  
  func dismiss(animated: Bool) {
  }
}
