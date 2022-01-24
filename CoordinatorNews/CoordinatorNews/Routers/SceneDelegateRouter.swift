import UIKit

class SceneDelegateRouter: NSObject, Router {
  
  private let window: UIWindow
  private var navigationController: UINavigationController
  private var onDismissForViewController: [
    UIViewController: (() -> Void)?
  ] = [:]
  
  
  init(window: UIWindow) {
    self.window = window
    self.navigationController = UINavigationController()
    super.init()
    
    navigationController.delegate = self
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
  
  func present(
    _ viewController: UIViewController,
    animated: Bool,
    onDismissed: (() -> Void)?) {
      onDismissForViewController[viewController] = onDismissed
      navigationController.pushViewController(
        viewController,
        animated: animated
      )
  }
  
  func dismiss(animated: Bool) {
    guard let routerRootViewController = navigationController.viewControllers.first else {
      navigationController.popToRootViewController(animated: true)
      return
    }
    performOnDismissed(for: routerRootViewController)
    navigationController.popToViewController(
      routerRootViewController,
      animated: animated
    )
  }
  
  private func performOnDismissed(for viewController: UIViewController) {
    guard let onDismiss = onDismissForViewController[viewController] else {
      return
    }
    onDismiss?()
    onDismissForViewController[viewController] = nil
  }
}

//MARK: - UINavigationControllerDelegate
extension SceneDelegateRouter: UINavigationControllerDelegate {
  func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool) {
      guard let dismissedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(dismissedViewController) else { return }
      performOnDismissed(for: dismissedViewController)
  }
}
