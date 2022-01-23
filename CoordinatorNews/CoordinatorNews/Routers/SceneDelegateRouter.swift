import UIKit

class SceneDelegateRouter: Router {
  
  let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func present(
    _ viewController: UIViewController,
    animated: Bool,
    onDismissed: (() -> Void)?) {
      window.rootViewController = viewController
      window.makeKeyAndVisible()
  }
  
  func dismiss(animated: Bool) { }
}
