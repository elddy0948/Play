import UIKit

class SceneRouter: Router {
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func present(_ viewController: UIViewController,
               animated: Bool, onDismissed: (() -> Void)?) {
    setupNavigationBarAppearance()
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
  func dismiss(animated: Bool) { }
  
  private func setupNavigationBarAppearance() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .systemBackground
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
  }
}
