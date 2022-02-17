import UIKit

class TodoListRouter: Router {
  private var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func present(_ viewController: UIViewController,
               animated: Bool,
               onDismissed: (() -> Void)?) {
    navigationController.pushViewController(
      viewController,
      animated: animated
    )
  }
  
  func presentModally(
    _ viewController: UIViewController,
    animated: Bool,
    onDismissed: (() -> Void)?
  ) {
    navigationController.present(
      viewController,
      animated: animated,
      completion: nil
    )
  }
  
  func dismiss(animated: Bool) { }
}
