import UIKit

class TabBarRouter: NSObject {
  private var tabBarController: UITabBarController
  private var viewControllers: [UIViewController] = []
  
  init(tabBarController: UITabBarController) {
    self.tabBarController = tabBarController
    super.init()
  }
}

extension TabBarRouter: Router {
  func present(
    _ viewController: UIViewController,
    animated: Bool,
    onDismissed: (() -> Void)?) {
      viewControllers.append(viewController)
      
      tabBarController.setViewControllers(
        self.viewControllers,
        animated: animated
      )
    }
  
  func dismiss(animated: Bool) { }
}
